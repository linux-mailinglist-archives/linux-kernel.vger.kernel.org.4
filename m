Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685E16066D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJTRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJTRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:16:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FDA1BC169
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:16:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k2so1147857ejr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2TXBtgerhY2vz40E1BiNZvR68nOLcA3rB68dKpPRhG8=;
        b=B5gHnbiJXUdhDCzqMJgOcQkFsziUWONNHtddTx6t98hLgp6MGEal7sjQxgUOyA3rFU
         Qfq/T1ymFmWUeV/2sKscRxxP9yEujBmFXTrXtQKlEy8RFKQ94lGmyL5tzMcXuS0N2Gb8
         SHyUQgUU2mHg3ZntaVaxS230u+Pm/pL5POmr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TXBtgerhY2vz40E1BiNZvR68nOLcA3rB68dKpPRhG8=;
        b=D+v0lJt31C4RPE0nutCeGksgIgvxoFnUNOVX9Pe17+PCO5gyINU8Hh1PnfoeIPOzEv
         uCFfB7R9XnOR+qcnUESHsFevANOeuNA1TphHV2IfZjF5pIp/yI8mjipf8kY3DbdIyq1u
         R7cvBAjuUHDN2JDD4aWKeNZvm4LhlNsyDYZ10LCo2d6oal3F/uevydIZJLpFks6y/Zk/
         esxMwr22iF0GcGSRWor2VEMs78dm6tXwFVPo0L3wXE5MmVfq0WZYPC6gtfnJoyMG28ip
         bd8wElN2RFmJTB/hD2U1oFOTIszAlbwM78J75QiWZTrFRIJ0ruDLPMQUZdlU/FnmJKPR
         oyMg==
X-Gm-Message-State: ACrzQf313ckLrmhqeIBg6wv68uEK2pt0Ae9r2WpWMpGvTG8FYIpgqq0U
        Xmle8v2kpUqRXj+94k7nQDS3By+RH4uATUxK6gQ=
X-Google-Smtp-Source: AMsMyM6bC5wN24PM0SZxciSWydbelPzFqLPVtsGPRimVwn7ml+FgVZ6Nr9yRUicvB+/tuLDkEipp0g==
X-Received: by 2002:a17:906:ee8e:b0:730:3646:d178 with SMTP id wt14-20020a170906ee8e00b007303646d178mr12102021ejb.426.1666286171841;
        Thu, 20 Oct 2022 10:16:11 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906328d00b007822196378asm10758952ejw.176.2022.10.20.10.16.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 10:16:09 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so124072wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:16:08 -0700 (PDT)
X-Received: by 2002:a1c:7215:0:b0:3c7:130c:a77f with SMTP id
 n21-20020a1c7215000000b003c7130ca77fmr1992230wmc.151.1666286168514; Thu, 20
 Oct 2022 10:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221014083058.1451914-1-ken_lin5@hotmail.com> <TYAPR03MB3085DD9F15177F126E9DF7C6AE249@TYAPR03MB3085.apcprd03.prod.outlook.com>
In-Reply-To: <TYAPR03MB3085DD9F15177F126E9DF7C6AE249@TYAPR03MB3085.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Oct 2022 10:15:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WH9N4Vx6e7Qr8q1fxsTRh=1kHBcg5RuWxOmruJEvr4kw@mail.gmail.com>
Message-ID: <CAD=FV=WH9N4Vx6e7Qr8q1fxsTRh=1kHBcg5RuWxOmruJEvr4kw@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme-pci: disable write zeros support on WD SSDs
To:     Ken Lin <ken_lin5@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        michael.jao@quanta.corp-partner.google.com, derekhuang@google.com,
        chi-jen.chen@quanta.corp-partner.google.com,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 14, 2022 at 1:32 AM Ken Lin <ken_lin5@hotmail.com> wrote:
>
> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> Write Zeroes command"), Western Digital has the same issue:
> [ 6305.633887] blk_update_request: operation not supported error,
> dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES)
> flags 0x0 phys_seg 0 prio class 0
>
> So also disable Write Zeroes command on Western Digital.
>
> Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
> ---
>
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3a1c37f32f30..5c1b812a3c2b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3517,6 +3517,8 @@ static const struct pci_device_id nvme_id_table[] = {
>                 .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
>         { PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
>                 .driver_data = NVME_QUIRK_BOGUS_NID, },
> +       { PCI_DEVICE(0x15b7, 0x501e),   /* Sandisk 2280 NVMe SSD  */
> +               .driver_data = NVME_QUIRK_NO_DEEPEST_PS, },

So I'm not really an expert and don't really have the context, but you
CCed me and so I took a quick glance.

Something smells a little fishy. ${SUBJECT} talks about disabling
"write zeros". The patch description talks about disabling "Write
Zeroes". The patch you reference seems to disable "write zeros" by
setting the quirk NVME_QUIRK_DISABLE_WRITE_ZEROES. ...but the contents
of your patch doesn't seem to match. Instead it adds the quirk
NVME_QUIRK_NO_DEEPEST_PS.

As I said, I'm not an expert and maybe everyone will tell me that it
all makes sense, but it seems weird.

-Doug
