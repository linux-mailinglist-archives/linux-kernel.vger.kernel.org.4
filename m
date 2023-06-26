Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0086973D993
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFZIYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjFZIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:24:21 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7549B95
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:24:20 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e662:523d:cfc0:1ef2])
        by xavier.telenet-ops.be with bizsmtp
        id DkQJ2A00M0kkhwT01kQJu7; Mon, 26 Jun 2023 10:24:18 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qDhWE-000QOP-FG;
        Mon, 26 Jun 2023 10:24:18 +0200
Date:   Mon, 26 Jun 2023 10:24:18 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.4
In-Reply-To: <20230626081950.2090627-1-geert@linux-m68k.org>
Message-ID: <39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org>
References: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com> <20230626081950.2090627-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.4[1] to v6.4-rc7[3], the summaries are:
>  - build errors: +1/-0

   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45

sh4-gcc11/sh-allmodconfig
seen before

This is actually a real issue, and it's been here since basically forever.

drivers/net/wireless/cisco/airo.c:

     static int airo_get_rate(struct net_device *dev,
                              struct iw_request_info *info,
                              union iwreq_data *wrqu,
                              char *extra)
     {
             struct iw_param *vwrq = &wrqu->bitrate;
             struct airo_info *local = dev->ml_priv;
             StatusRid status_rid;           /* Card status info */

             readStatusRid(local, &status_rid, 1);

==>         vwrq->value = le16_to_cpu(status_rid.currentXmitRate) * 500000;
             ...
     }

     static int readStatusRid(struct airo_info *ai, StatusRid *statr, int lock)
     {
             return PC4500_readrid(ai, RID_STATUS, statr, sizeof(*statr), lock);
     }

     static int PC4500_readrid(struct airo_info *ai, u16 rid, void *pBuf, int len, int lock)
     {
             u16 status;
             int rc = SUCCESS;

             if (lock) {
                     if (down_interruptible(&ai->sem))
                             return ERROR;

pBuf output buffer contents not initialized.

             }
             ...
     }


> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6995e2de6891c724bfeb2db33d7b87775f913ad1/ (all 160 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/45a3e24f65e90a047bef86f927ebdc4c710edaa1/ (all 160 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
