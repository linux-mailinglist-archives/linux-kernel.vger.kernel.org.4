Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44674ED94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGKMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:08:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD1E5C;
        Tue, 11 Jul 2023 05:08:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31B7467373; Tue, 11 Jul 2023 14:08:06 +0200 (CEST)
Date:   Tue, 11 Jul 2023 14:08:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Azat Khuzhin <a3at.mail@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Fix writing maj:min to /sys/power/resume (fixes
 hiberation with systemd)
Message-ID: <20230711120806.GA27809@lst.de>
References: <20230711114821.1273-1-a3at.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711114821.1273-1-a3at.mail@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:48:12PM +0200, Azat Khuzhin wrote:
> resume_store() first calls lookup_bdev() and after tries to handle
> maj:min, but it does not reset the error before, hence if you will write
> maj:min you will get ENOENT:
> 
>     # echo 259:2 >| /sys/power/resume
>     bash: echo: write error: No such file or directory
> 
> This also should fix hiberation via systemd, since it uses this way.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
