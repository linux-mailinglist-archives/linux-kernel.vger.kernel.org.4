Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E432E68A35F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBCUGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjBCUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:06:01 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99199E9F9;
        Fri,  3 Feb 2023 12:05:59 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-16a10138faeso1626804fac.11;
        Fri, 03 Feb 2023 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NsybNzVGNY7+c9dcFyxwjPYsZx5BhCAmHivktG61Os0=;
        b=VyFRQFgGlHrfdtNiwu+d46Gh7P2vXa3jxBc23PucD0hVEYdqhWEfC28ZwJX6dw0Muu
         sYn4HJ7PlhbvkjS6BBfXFUCcEe3unvgu86u9p+idXiFaOCO+sgynPdwgcUBXO3D/zvpl
         hFtjyKrbOepOabr3cAJ6pcB1zLleHVQyRY3I6QeD7O/SKak6BOoOjPt0SQ/Khj2q/x7Z
         MQT86Vx8vQGr/C7Ds1Rjq4/W8BVMbDGZDNtDmJgK83sKMapm/fLq4RCFA4j36pKhAXnQ
         goFl3SnLZSLTLZQzjyHL2wD3y3HhZi5Jm0ZuSvcDsuQQ2Fp0oTTsPUdDHoYYGzNguUVh
         QhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsybNzVGNY7+c9dcFyxwjPYsZx5BhCAmHivktG61Os0=;
        b=2lSYHt67+5LFEPS+CX0D92puT31zJ7Z+hOXaKh4zCQZvg6JGoZlzBAa3psAO+3PFen
         z2fTaUaz0fnsNLkSI1C4EtEWp8Qyr2GVSeXjXJbZYTt3LOGKJfPOXATCS/A2nUj0pfHb
         SUmS7d8OdhojW+AEhIQFVfFZzdAiCkWPYSKapNZpwnf1g8VT5yOa9Q6xWpHRA6Kezw38
         MpHg+8FwyTYwb96iOEqi30PMY+oYS+GmDYKmB1MzRpPockRtbPHH7fOA2LSLyzUn1W9a
         nhx2AV+pxd9XGscZpTtSFmE120WPXr/xxFGqKfvxwOUTkf9PtNIQ5wA8ZFC8XePjOCjp
         toIA==
X-Gm-Message-State: AO0yUKWanQR1V9mAb2mcj34YmUyhSl8Jc0u85HfiNKWDjFedFCaOlUKF
        1WBBxCQZ6TvaLQE6RxKOg3fR4q+lzzTBM10L6Kc=
X-Google-Smtp-Source: AK7set99kNPa5OUNu3UFb0Uh7hUVOdYE3mt+q4Mu76G5kd5h2cv/XsWjmRVkfx5Jxu1oGDW/5N/bjdava2HHWG60fek=
X-Received: by 2002:a05:6870:b294:b0:163:babd:12e with SMTP id
 c20-20020a056870b29400b00163babd012emr1021969oao.146.1675454758071; Fri, 03
 Feb 2023 12:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20221227001001.51626-1-zh.nvgt@gmail.com> <9b0f6779-e2a5-54f1-2b9c-6bc42c6d3d90@redhat.com>
In-Reply-To: <9b0f6779-e2a5-54f1-2b9c-6bc42c6d3d90@redhat.com>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Fri, 3 Feb 2023 15:05:47 -0500
Message-ID: <CAO2zrtbaz2XF+vHW6mC_+gUNwwkWffupbp2jg8_sWgcguy5AKA@mail.gmail.com>
Subject: Re: [PATCH] scsi: dpt_i2o: fix a potential use-after-free in __adpt_reset()
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 11:07 AM Tomas Henzl <thenzl@redhat.com> wrote:
>
> Hi Hang,
>
> with b04e75a4a8a8 scsi: dpt_i2o: Remove obsolete driver
> was the driver removed from kernel.
>
> Regards,
> Tomas
>

Hi Tomas, thank you very much for pointing this out! I'm wondering
that is this removal for all the kernel versions, or there might still be
some maintained versions using this driver (e.g., from a quick check
it seems the longterm 5.15.91 still has the driver)? If so, do you think
this is a valid issue that we need to fix in some prior affected
longterm kernel versions? Thank you for your help and comments!

Best,
Hang

> On 12/27/22 01:10, Hang Zhang wrote:
>
> __adpt_reset() invokes adpt_hba_reset(), which can free "pHba"
> on error paths and return an negative error code in those
> situations. The problem is that "pHba" is from the global pointer
> "cmd->device->host->hostdata[0]", regardless of the possible free
> of "pHba", that original global pointer is never nullified and
> thus may become a dangling pointer and be dereferenced later,
> potentially causing a use-after-free.
>
> Fix the issue by nullifying "cmd->device->host->hostdata[0]" if
> adpt_hba_reset() returns a negative error code to __adpt_reset(),
> which indicates the free of "pHba". Also add a NULL check before
> any dereference of "pHba", or the aliased global pointer. Note
> that the similar NULL check already exists at other places, like
> in adpt_queue_lck().
>
> Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> ---
>  drivers/scsi/dpt_i2o.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
> index 2e9155ba7408..9827517a1898 100644
> --- a/drivers/scsi/dpt_i2o.c
> +++ b/drivers/scsi/dpt_i2o.c
> @@ -753,6 +753,9 @@ static int __adpt_reset(struct scsi_cmnd* cmd)
>   char name[32];
>
>   pHba = (adpt_hba*)cmd->device->host->hostdata[0];
> + if (!pHba) {
> + return FAILED;
> + }
>   strncpy(name, pHba->name, sizeof(name));
>   printk(KERN_WARNING"%s: Hba Reset: scsi id %d: tid: %d\n", name, cmd->device->channel, pHba->channel[cmd->device->channel].tid);
>   rcode =  adpt_hba_reset(pHba);
> @@ -760,6 +763,7 @@ static int __adpt_reset(struct scsi_cmnd* cmd)
>   printk(KERN_WARNING"%s: HBA reset complete\n", name);
>   return SUCCESS;
>   } else {
> + cmd->device->host->hostdata[0] = NULL;
>   printk(KERN_WARNING"%s: HBA reset failed (%x)\n", name, rcode);
>   return FAILED;
>   }
>
>
