Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0A617569
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKCENY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiKCENN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:13:13 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FFB13F1A;
        Wed,  2 Nov 2022 21:13:12 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id t16so397504qvm.9;
        Wed, 02 Nov 2022 21:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+25QrJbrFzP445hxbERz2MlFDjVBgfsITwfv/Zbzww=;
        b=Ck0fdPTnKcav/x3nHbHg8fjUSvMBOKipfGIyHC7Io6+DUUyJnO3ShH2fSOefd5UPo1
         plv9fW0f3ZgR1ywrfvaCfedLakl+P7l0j8xcav9yQAG2lDkuwJRhJaYnC+4uTf8B9Sbs
         SvIHhhJ9y0yHWX4KL+KfY65kXN+9NwFLXWV6/nJ4x+B9Kjot1R9XkD7OWWGgQiLBcocn
         kbGvS16N3xnfa1JVIp3clTiQYOHrnb/iUO+1EzuxVdtTG8Aoaqn5bEuXXQIbNs/j0xkd
         46ix9XU3LeauBNQuI9cauegx9TPSHRcH34K5Rx+9kIUFNulPSVCS3FCwMidJh3F+djPu
         dwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+25QrJbrFzP445hxbERz2MlFDjVBgfsITwfv/Zbzww=;
        b=eksX2BiqZQ2Lmpkf38LLROsggISgOq2Zw09tNWoBOeEu06c4KxXfVtDin7hXgj91uJ
         0+U9f6PNwgMV+PQMpGpqwzwNe3xFYXNBQIl0AHF/uY86ntZwJ0GkqGUpHEQl7b5R2Zav
         AOa/tqUUg1brUWhva7M9/RdAXtBjTEtBTid6sZz/GYEfjCXjXrodkSja1e/uTmw9mSA9
         7TJKbGylaweh62mqzOW17WnLGYEwBRnBsaDuIXvK8nQxD3lNc6nAKfOhGtpUoFR1idyf
         bl0H+SSkF8TUMB/HCwh549KHbBLkCPUCoufuSg6tvXd5jL6oVv7I+1l05vwv1nEpgYGe
         cv6g==
X-Gm-Message-State: ACrzQf0e+buhXSlMSjXjxx3H3e0s/RwHQTbLu+zdgGDKCV4xuj8QXUrk
        Tm+DZ6n881JG+S5d3N8StXN05YIke4yQPVYGoC8=
X-Google-Smtp-Source: AMsMyM62dWep4UxJRWKfeTJOcl6GQDKgVIgBCNwxYeko9+tLuMFIJBXzcGAM5B3maWI/O7YwCAsN3w2CIpGUxIG8934=
X-Received: by 2002:a05:6214:3005:b0:4ad:8042:128a with SMTP id
 ke5-20020a056214300500b004ad8042128amr25151091qvb.66.1667448791800; Wed, 02
 Nov 2022 21:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221028050736.151185-1-zyytlz.wz@163.com> <0ce67c60-7b55-6f29-2f97-9b17c1e175c0@gmail.com>
In-Reply-To: <0ce67c60-7b55-6f29-2f97-9b17c1e175c0@gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 3 Nov 2022 12:12:59 +0800
Message-ID: <CAJedcCzvkcnkntM6h3NAV6ct36RY-bKyHichQ4ecRop7wfHuhg@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: fix double free bug in lpfc_bsg_write_ebuf_set
To:     James Smart <jsmart2021@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Smart <jsmart2021@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=9B=9B 00:37=E5=86=99=E9=81=93=EF=BC=9A

> Minimally, just looking at this one snippet, by returning after the
> mempool_alloc() failure, we are leaking the dd_data memory just allocated=
.
>

Yes, this is a bad patch.

> > @@ -4480,8 +4478,7 @@ lpfc_bsg_write_ebuf_set(struct lpfc_hba *phba, st=
ruct bsg_job *job,
> >               lpfc_printf_log(phba, KERN_ERR, LOG_LIBDFC,
> >                               "2970 Failed to issue SLI_CONFIG ext-buff=
er "
> >                               "mailbox command, rc:x%x\n", rc);
> > -             rc =3D -EPIPE;
> > -             goto job_error;
> > +             return -EPIPE;
>
> and this leaks both the dd_data and pmboxq memory.

So Here it is.

>
> all of these errors should cause:
>    lpfc_bsg_write_ebuf_set() to return -Exxx
>    causing lpfc_bsg_handle_sli_cfg_ebuf() to return -Exxx
>    causing lpfc_bsg_handle_sli_cfg_ext() to return -Exxx
>    which causes lpfc_bsg_issue_mbox() to jump to job_done
>

Hi James! Really apprecaite for your reply. I was not sure if it it a
really issue. Sorry for the bad patch.

> I understand the argument is that issue_mbox deletes them, but....
>
> job_done:
>    checks/frees pmboxq is allocated after the jump so it will be NULL
>    frees dmabuf - which was allocated prior to the jump; is freed
>       in freedlpfc_bsg_handle_sli_cfg_ebuf() but only in a block
>       that returns SLI_CONFIG_HANDLED, which is not the block that
>       invokes lpfc_bsg_write_ebuf_set. So it's valid to delete.
>       Note: there's a special case for SLI_CONFIG_HANDLED which skips
>       over these deletes so it's ok.
>    frees dd_data - which is allocated after the jump so it too will
>       be NULL

I understood your point. Here is a call chain :
 lpfc_bsg_issue_mbox->lpfc_bsg_handle_sli_cfg_ext->lpfc_bsg_handle_sli_cfg_=
ebuf->lpfc_bsg_write_ebuf_set->lpfc_bsg_dma_page_free->kfree(dmabuf)
It leads to another kfree in lpfc_bsg_mbox_cmd :
job_done:
    /* common exit for error or job completed inline */
    if (pmboxq)
        mempool_free(pmboxq, phba->mbox_mem_pool);
    [7] lpfc_bsg_dma_page_free(phba, dmabuf);
    kfree(dd_data);

So the key point is whether phba->mbox_ext_buf_ctx.mboxType can be
mbox_wr. If not, just as you illustrated, all is fine.
It will get into SLI_CONFIG_HANDLED path and handle dmabuf as expected.

But if not, it will have a chance to trigger a double-free bug. I
found phda is assigned in lpfc_bsg_mbox_cmd. But I am still not sure
about its value.
Appreciate if you can help me to understand more about the key condition :)

> So - the code is fine.  The SLI_CONFIG_HANDLED is a little weird, but
> the logic is fine. If the patch were added it would leak memory.
>
> I take it this was identified by some tool ?
>

Yes, I found it using Codeql. I didn't have a poc to verify.

Best Regards,
Zheng Wang
