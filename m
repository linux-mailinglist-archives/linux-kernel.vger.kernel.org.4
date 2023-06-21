Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6859C738195
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjFUKb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjFUKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:31:16 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EDC1BCB;
        Wed, 21 Jun 2023 03:30:22 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-78a3e1ed1deso1861646241.1;
        Wed, 21 Jun 2023 03:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343421; x=1689935421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1reaD1V+YmgCTsvpSr0zit3P0vA3iJ/xCi619ZA4Y+Y=;
        b=RhIkwx1IiUzHBMD1l9hQk6fOAchUJ9TJXU7nMKxPP9hOsoYECTdAF4RcbauI3WnIVz
         bhHrrcAMwdT0ejme2UlR88st0/FqbB24J35z55juEDJlQI0b5HFWtMP5i1SM3jm8fEib
         Bnkxwy8i4H//wAjEE6Yo15KgXr7vg6JRWRu1yilOHcRQyBuNk/G28YGaaan0rltyn4b7
         CrwM4ziPEdE8pMAgj1W2yVg3D5QCTFl6iHTLM7W4x4r2d/V9+4/T9ywTxkWfqqu7UnJn
         P0+KaASlPl9yUPTfd3lWBsrBp73APVDtXXnorb+od1UxyG/56l1Jubmh+ZMLF0AU1j/x
         hwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343421; x=1689935421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1reaD1V+YmgCTsvpSr0zit3P0vA3iJ/xCi619ZA4Y+Y=;
        b=dKYCYNdC3wL7tBy31iD1CX64JqUwMyUpCi8opUeGiOQek4bQyCj+ffjmHcZnZod0R6
         9pP3QTBZHsvNDcXtI30GqOmGT8osKmgeXCsMvqrWCaLKUlBMuw8HzLQyepLgNrVTTsFz
         DfVzRR4zgujfg5hKymWO7SeK2sQVuD8el4MzUnC3Zu5dESTlydYeN4v9Ha4iqVe97H6N
         fXyeFbtqXW3k+bITSODmRsmTeiqm99JNZe8ocSYEOCH3N14YbESC1rxCd6nsIiXnKG0B
         MqFlTZD7knkNQtAml+kkv/qaTNDNXvxrnDTGHIsDilrCY/4ITulqj2SOU6NHpPJeIHcb
         vZRA==
X-Gm-Message-State: AC+VfDy6YHiKStUinBj3Hq9moDpSXyabchOlpkH+w7AdPXiL3axTysmK
        DfgfE57e5OBnnL2vAVTjPqN7+yHnUhq4pV4tuiY=
X-Google-Smtp-Source: ACHHUZ4FfaMZVq3L2slJ9JE9NcFhP8uuPaCazPLBxTWQA1luaHekW3HNje1erqrLb8rHWdGxSCWlv527YIGGJ4w4ieE=
X-Received: by 2002:a67:ba08:0:b0:440:d269:d237 with SMTP id
 l8-20020a67ba08000000b00440d269d237mr1331343vsn.30.1687343421299; Wed, 21 Jun
 2023 03:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-20-victor.shih@genesyslogic.com.tw> <2773a596-146c-ba28-8100-69d9a91db1ff@intel.com>
In-Reply-To: <2773a596-146c-ba28-8100-69d9a91db1ff@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:30:09 +0800
Message-ID: <CAK00qKB_sm_xyBNHB+o=7gHHp90WBbmomyCs5c5tm6uEtXpRRA@mail.gmail.com>
Subject: Re: [PATCH V7 19/23] mmc: sdhci-uhs2: add irq() and others
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, Apr 12, 2023 at 9:12=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/03/23 13:55, Victor Shih wrote:
> > This is a UHS-II version of sdhci's request() operation.
> > It handles UHS-II related command interrupts and errors.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 215 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |   3 +
> >  drivers/mmc/host/sdhci.c      | 106 +++++++++--------
> >  drivers/mmc/host/sdhci.h      |   5 +
> >  4 files changed, 283 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index a9655b9546ea..63f4bfce70b8 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -789,6 +789,221 @@ static void sdhci_uhs2_finish_command(struct sdhc=
i_host *host)
> >               __sdhci_finish_mrq(host, cmd->mrq);
> >  }
> >
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Request done                                                       =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> > +{
> > +     unsigned long flags;
> > +     struct mmc_request *mrq;
> > +     int i;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     for (i =3D 0; i < SDHCI_MAX_MRQS; i++) {
> > +             mrq =3D host->mrqs_done[i];
> > +             if (mrq)
> > +                     break;
> > +     }
> > +
> > +     if (!mrq) {
> > +             spin_unlock_irqrestore(&host->lock, flags);
> > +             return true;
> > +     }
> > +
> > +     /*
> > +      * Always unmap the data buffers if they were mapped by
> > +      * sdhci_prepare_data() whenever we finish with a request.
> > +      * This avoids leaking DMA mappings on error.
> > +      */
> > +     if (host->flags & SDHCI_REQ_USE_DMA)
> > +             sdhci_request_done_dma(host, mrq);
> > +
> > +     /*
> > +      * The controller needs a reset of internal state machines
> > +      * upon error conditions.
> > +      */
> > +     if (sdhci_needs_reset(host, mrq)) {
> > +             /*
> > +              * Do not finish until command and data lines are availab=
le for
> > +              * reset. Note there can only be one other mrq, so it can=
not
> > +              * also be in mrqs_done, otherwise host->cmd and host->da=
ta_cmd
> > +              * would both be null.
> > +              */
> > +             if (host->cmd || host->data_cmd) {
> > +                     spin_unlock_irqrestore(&host->lock, flags);
> > +                     return true;
> > +             }
> > +
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +             host->pending_reset =3D false;
> > +     }
> > +
> > +     host->mrqs_done[i] =3D NULL;
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     if (host->ops->request_done)
> > +             host->ops->request_done(host, mrq);
> > +     else
> > +             mmc_request_done(host->mmc, mrq);
> > +
> > +     return false;
> > +}
> > +
> > +static void sdhci_uhs2_complete_work(struct work_struct *work)
> > +{
> > +     struct sdhci_host *host =3D container_of(work, struct sdhci_host,
> > +                                            complete_work);
> > +
> > +     if (!sdhci_uhs2_mode(host)) {
> > +             sdhci_complete_work(work);
> > +             return;
> > +     }
> > +
> > +     while (!sdhci_uhs2_request_done(host))
> > +             ;
> > +}
> > +
> > +/*********************************************************************=
********\
> > + *                                                                    =
       *
> > + * Interrupt handling                                                 =
       *
> > + *                                                                    =
       *
> > +\*********************************************************************=
********/
> > +
> > +static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
> > +{
> > +     struct mmc_command *cmd =3D host->cmd;
> > +
> > +     DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
> > +         mmc_hostname(host->mmc), uhs2mask);
> > +
> > +     if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
> > +             if (!host->cmd) {
> > +                     pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\=
n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +             host->cmd->error =3D -EILSEQ;
> > +             if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
> > +                     host->cmd->error =3D -ETIMEDOUT;
> > +     }
> > +
> > +     if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
> > +             if (!host->data) {
> > +                     pr_err("%s: Got data interrupt 0x%08x but no data=
.\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +
> > +             if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
> > +                     pr_err("%s: Got deadlock timeout interrupt 0x%08x=
\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     host->data->error =3D -ETIMEDOUT;
> > +             } else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
> > +                     pr_err("%s: ADMA error =3D 0x %x\n",
> > +                            mmc_hostname(host->mmc),
> > +                            sdhci_readb(host, SDHCI_ADMA_ERROR));
> > +                     host->data->error =3D -EIO;
> > +             } else {
> > +                     host->data->error =3D -EILSEQ;
> > +             }
> > +     }
> > +
> > +     if (host->data && host->data->error)
> > +             sdhci_uhs2_finish_data(host);
> > +     else
> > +             sdhci_finish_mrq(host, cmd->mrq);
> > +}
> > +
> > +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
> > +{
> > +     u32 mask =3D intmask, uhs2mask;
> > +
> > +     if (!sdhci_uhs2_mode(host))
> > +             goto out;
> > +
> > +     if (intmask & SDHCI_INT_ERROR) {
> > +             uhs2mask =3D sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
> > +             if (!(uhs2mask & SDHCI_UHS2_INT_ERROR_MASK))
> > +                     goto cmd_irq;
> > +
> > +             /* Clear error interrupts */
> > +             sdhci_writel(host, uhs2mask & SDHCI_UHS2_INT_ERROR_MASK,
> > +                          SDHCI_UHS2_INT_STATUS);
> > +
> > +             /* Handle error interrupts */
> > +             __sdhci_uhs2_irq(host, uhs2mask);
> > +
> > +             /* Caller, sdhci_irq(), doesn't have to care about UHS-2 =
errors */
> > +             intmask &=3D ~SDHCI_INT_ERROR;
> > +             mask &=3D SDHCI_INT_ERROR;
> > +     }
> > +
> > +cmd_irq:
> > +     if (intmask & SDHCI_INT_CMD_MASK) {
> > +             /* Clear command interrupt */
> > +             sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_IN=
T_STATUS);
> > +
> > +             /* Handle command interrupt */
> > +             if (intmask & SDHCI_INT_RESPONSE)
> > +                     sdhci_uhs2_finish_command(host);
> > +
> > +             /* Caller, sdhci_irq(), doesn't have to care about UHS-2 =
commands */
> > +             intmask &=3D ~SDHCI_INT_CMD_MASK;
> > +             mask &=3D SDHCI_INT_CMD_MASK;
> > +     }
> > +
> > +     /* Clear already-handled interrupts. */
> > +     sdhci_writel(host, mask, SDHCI_INT_STATUS);
> > +
> > +out:
> > +     return intmask;
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
> > +
> > +static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
> > +{
> > +     struct sdhci_host *host =3D dev_id;
> > +     struct mmc_command *cmd;
> > +     unsigned long flags;
> > +     u32 isr;
> > +
> > +     if (!sdhci_uhs2_mode(host))
> > +             return sdhci_thread_irq(irq, dev_id);
> > +
> > +     while (!sdhci_uhs2_request_done(host))
> > +             ;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     isr =3D host->thread_isr;
> > +     host->thread_isr =3D 0;
> > +
> > +     cmd =3D host->deferred_cmd;
> > +     if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
> > +             sdhci_finish_mrq(host, cmd->mrq);
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> > +             struct mmc_host *mmc =3D host->mmc;
> > +
> > +             mmc->ops->card_event(mmc);
> > +             mmc_detect_change(mmc, msecs_to_jiffies(200));
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  {
> >       struct sdhci_host *host =3D mmc_priv(mmc);
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index 33e03b1b2b80..f733c733c692 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -182,5 +182,8 @@ bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd);
> >  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set);
> > +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)=
;
> > +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request=
 *mrq);
>
> Should forward declare 'struct mmc_request' like 'struct mmc_host'
>

I will update it to the V8 version.

> > +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 55725edd4b91..b3cf4a26eed5 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -47,6 +47,8 @@
> >  static unsigned int debug_quirks =3D 0;
> >  static unsigned int debug_quirks2;
> >
> > +static bool sdhci_send_command(struct sdhci_host *host, struct mmc_com=
mand *cmd);
> > +
>
> Should not have been removed in previous patch.
>

I will update it to the V8 version.

> >  void sdhci_dumpregs(struct sdhci_host *host)
> >  {
> >       SDHCI_DUMP("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER D=
UMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> > @@ -1495,7 +1497,7 @@ static void sdhci_set_transfer_mode(struct sdhci_=
host *host,
> >       sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
> >  }
> >
> > -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_requ=
est *mrq)
> > +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mr=
q)
> >  {
> >       return (!(host->flags & SDHCI_DEVICE_DEAD) &&
> >               ((mrq->cmd && mrq->cmd->error) ||
> > @@ -1503,8 +1505,9 @@ static bool sdhci_needs_reset(struct sdhci_host *=
host, struct mmc_request *mrq)
> >                (mrq->data && mrq->data->stop && mrq->data->stop->error)=
 ||
> >                (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_needs_reset);
> >
> > -static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_req=
uest *mrq)
> > +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *m=
rq)
> >  {
> >       int i;
> >
> > @@ -1524,6 +1527,7 @@ static void sdhci_set_mrq_done(struct sdhci_host =
*host, struct mmc_request *mrq)
> >
> >       WARN_ON(i >=3D SDHCI_MAX_MRQS);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_set_mrq_done);
> >
> >  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *m=
rq)
> >  {
> > @@ -3106,6 +3110,55 @@ static const struct mmc_host_ops sdhci_ops =3D {
> >   *                                                                    =
       *
> >  \*********************************************************************=
********/
> >
> > +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_reques=
t *mrq)
> > +{
> > +     struct mmc_data *data =3D mrq->data;
> > +
> > +     if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> > +             if (host->bounce_buffer) {
> > +                     /*
> > +                      * On reads, copy the bounced data into the
> > +                      * sglist
> > +                      */
> > +                     if (mmc_get_dma_dir(data) =3D=3D DMA_FROM_DEVICE)=
 {
> > +                             unsigned int length =3D data->bytes_xfere=
d;
> > +
> > +                             if (length > host->bounce_buffer_size) {
> > +                                     pr_err("%s: bounce buffer is %u b=
ytes but DMA claims to have transferred %u bytes\n",
> > +                                            mmc_hostname(host->mmc),
> > +                                            host->bounce_buffer_size,
> > +                                            data->bytes_xfered);
> > +                                     /* Cap it down and continue */
> > +                                     length =3D host->bounce_buffer_si=
ze;
> > +                             }
> > +                             dma_sync_single_for_cpu(
> > +                                     host->mmc->parent,
>
> host->mmc->parent -> mmc_dev(host->mmc)
>

I will update it to the V8 version.

> > +                                     host->bounce_addr,
> > +                                     host->bounce_buffer_size,
> > +                                     DMA_FROM_DEVICE);
> > +                             sg_copy_from_buffer(data->sg,
> > +                                     data->sg_len,
> > +                                     host->bounce_buffer,
> > +                                     length);
> > +                     } else {
> > +                             /* No copying, just switch ownership */
> > +                             dma_sync_single_for_cpu(
> > +                                     host->mmc->parent,
>
> host->mmc->parent -> mmc_dev(host->mmc)
>

I will update it to the V8 version.

> > +                                     host->bounce_addr,
> > +                                     host->bounce_buffer_size,
> > +                                     mmc_get_dma_dir(data));
> > +                     }
> > +             } else {
> > +                     /* Unmap the raw data */
> > +                     dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> > +                                  data->sg_len,
> > +                                  mmc_get_dma_dir(data));
> > +             }
> > +             data->host_cookie =3D COOKIE_UNMAPPED;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
> > +
> >  static bool sdhci_request_done(struct sdhci_host *host)
> >  {
> >       unsigned long flags;
> > @@ -3170,48 +3223,7 @@ static bool sdhci_request_done(struct sdhci_host=
 *host)
> >                       sdhci_set_mrq_done(host, mrq);
> >               }
> >
> > -             if (data && data->host_cookie =3D=3D COOKIE_MAPPED) {
> > -                     if (host->bounce_buffer) {
> > -                             /*
> > -                              * On reads, copy the bounced data into t=
he
> > -                              * sglist
> > -                              */
> > -                             if (mmc_get_dma_dir(data) =3D=3D DMA_FROM=
_DEVICE) {
> > -                                     unsigned int length =3D data->byt=
es_xfered;
> > -
> > -                                     if (length > host->bounce_buffer_=
size) {
> > -                                             pr_err("%s: bounce buffer=
 is %u bytes but DMA claims to have transferred %u bytes\n",
> > -                                                    mmc_hostname(host-=
>mmc),
> > -                                                    host->bounce_buffe=
r_size,
> > -                                                    data->bytes_xfered=
);
> > -                                             /* Cap it down and contin=
ue */
> > -                                             length =3D host->bounce_b=
uffer_size;
> > -                                     }
> > -                                     dma_sync_single_for_cpu(
> > -                                             mmc_dev(host->mmc),
> > -                                             host->bounce_addr,
> > -                                             host->bounce_buffer_size,
> > -                                             DMA_FROM_DEVICE);
> > -                                     sg_copy_from_buffer(data->sg,
> > -                                             data->sg_len,
> > -                                             host->bounce_buffer,
> > -                                             length);
> > -                             } else {
> > -                                     /* No copying, just switch owners=
hip */
> > -                                     dma_sync_single_for_cpu(
> > -                                             mmc_dev(host->mmc),
> > -                                             host->bounce_addr,
> > -                                             host->bounce_buffer_size,
> > -                                             mmc_get_dma_dir(data));
> > -                             }
> > -                     } else {
> > -                             /* Unmap the raw data */
> > -                             dma_unmap_sg(mmc_dev(host->mmc), data->sg=
,
> > -                                          data->sg_len,
> > -                                          mmc_get_dma_dir(data));
> > -                     }
> > -                     data->host_cookie =3D COOKIE_UNMAPPED;
> > -             }
> > +             sdhci_request_done_dma(host, mrq);
> >       }
> >
> >       host->mrqs_done[i] =3D NULL;
> > @@ -3226,7 +3238,7 @@ static bool sdhci_request_done(struct sdhci_host =
*host)
> >       return false;
> >  }
> >
> > -static void sdhci_complete_work(struct work_struct *work)
> > +void sdhci_complete_work(struct work_struct *work)
> >  {
> >       struct sdhci_host *host =3D container_of(work, struct sdhci_host,
> >                                              complete_work);
> > @@ -3234,6 +3246,7 @@ static void sdhci_complete_work(struct work_struc=
t *work)
> >       while (!sdhci_request_done(host))
> >               ;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_complete_work);
> >
> >  static void sdhci_timeout_timer(struct timer_list *t)
> >  {
> > @@ -3689,7 +3702,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_i=
d)
> >       return result;
> >  }
> >
> > -static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> > +irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> >  {
> >       struct sdhci_host *host =3D dev_id;
> >       struct mmc_command *cmd;
> > @@ -3719,6 +3732,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void=
 *dev_id)
> >
> >       return IRQ_HANDLED;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_thread_irq);
> >
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 775407dad8da..9e9158f811b1 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -833,6 +833,8 @@ bool sdhci_data_line_cmd(struct mmc_command *cmd);
> >  void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,=
 unsigned long timeout);
> >  void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *d=
ata);
> >  void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)=
;
> > +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mr=
q);
> > +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *m=
rq);
> >  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *m=
rq);
> >  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
);
> >  void __sdhci_finish_data_common(struct sdhci_host *host);
> > @@ -862,6 +864,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc=
_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
> >  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> > +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_reques=
t *mrq);
> > +void sdhci_complete_work(struct work_struct *work);
> > +irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
> >  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> >                          dma_addr_t addr, int len, unsigned int cmd);
> >
>

Thanks, Victor Shih
