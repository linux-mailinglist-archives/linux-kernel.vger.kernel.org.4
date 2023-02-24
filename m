Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FE6A1A18
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBXKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBXKXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:23:35 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60751457CD;
        Fri, 24 Feb 2023 02:23:09 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w42so13943200qtc.2;
        Fri, 24 Feb 2023 02:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CaBOK0SOTc1yLg/ZVBmBUJ0a/JWzGgc1+xc6DqSnVeE=;
        b=VFGT88wrnczzfFYGRuqpKdGvRLGfaJBHFRLjg7bvhSu+yNVTGKrqcjP4a4jzjdbGC8
         F4KDfgqaizpp7fZ4YCSrOzb9gWyLqeUnSqu6WNuoLjfmgrVN1d/l3XSYLe7siqeyj/XF
         BH9Zkk3bs8N3+874UxCYsTkr6uitonMEw+bWENxQRtJVbCMSu4ChTrv3yq3c+xDLMLB+
         1Sw+fLl8SxeZ+lBJxwxsaakhsDEu+4kUvxVPAf0nPHrf5E0JKi9d2RsXrK9rcNeshCAI
         CbCfCMp2z5eHdBYUaUkuaC9q+Tv7s73w9riKqkNWJFd7ocIkxodD/yxgwzojnD2cGOSM
         yOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaBOK0SOTc1yLg/ZVBmBUJ0a/JWzGgc1+xc6DqSnVeE=;
        b=dnAVEntTbutZHqXMxb6I4y+za2fHxAoZoinYgpsbqmGGazs6HFVw3MS7/hnmE2V3eW
         EApjvIuAl9AQ2mIHTmC01uS11nbmAu5jxEC0fw2cEScAoRhaYtXcaq4FM3CaGVXpRq38
         WJIq+1RV88DdHrU6dBrfR754vEWEHU6XmI0L3WeJzPZTAP6Zk13tbuJewFYzixaWORYx
         84xZhTT3XwiCy/2td4GEGYs7GvtgUfJrHCevNCtw5PqLhSXig3vLG46qS1QvvlNdCK/k
         CZK3O68lDq95bBTrCtf/a8DP+fPWPwvXYp/v9jmsmOgFp1hDucv98VHxeFampn/hWS52
         SVeQ==
X-Gm-Message-State: AO0yUKVIrmrJOiDisfvy1k3wJuf0+YDqehZiyybxk1c4iwA3H1FCpqz9
        8cxT3yV5iUGQdRkp/6NAbaPBq3Ljvudj0sgk3VI=
X-Google-Smtp-Source: AK7set/jgByJ7ac/I7CiALBQVTXyOvQZ/qvX3y/iD10GyuLcvHOYSR//phfF0mQdQe/1NiPDAZL99SQWRAWTN8yVx2Y=
X-Received: by 2002:ac8:604e:0:b0:3bd:6c0:933d with SMTP id
 k14-20020ac8604e000000b003bd06c0933dmr2759090qtm.10.1677234188251; Fri, 24
 Feb 2023 02:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-20-victor.shih@genesyslogic.com.tw> <70292aff-1a87-b963-706e-8913c9d587f8@intel.com>
In-Reply-To: <70292aff-1a87-b963-706e-8913c9d587f8@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 24 Feb 2023 18:22:56 +0800
Message-ID: <CAK00qKAvoV8rf+pqf1vV6dJxrkWEQLsyphPtmzBxo0VxYs43HQ@mail.gmail.com>
Subject: Re: [PATCH V6 19/24] mmc: sdhci-uhs2: add irq() and others
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
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

Hi, Adrian

On Fri, Jan 6, 2023 at 5:30 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/12/22 11:00, Victor Shih wrote:
> > This is a UHS-II version of sdhci's request() operation.
> > It handles UHS-II related command interrupts and errors.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-uhs2.c | 223 +++++++++++++++++++++++++++++++++-
> >  drivers/mmc/host/sdhci-uhs2.h |   3 +
> >  drivers/mmc/host/sdhci.c      | 111 +++++++++--------
> >  drivers/mmc/host/sdhci.h      |   6 +
> >  4 files changed, 294 insertions(+), 49 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> > index 7a34f66c4215..769cf88b21cf 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/ktime.h>
> >  #include <linux/mmc/mmc.h>
> > +#include <linux/dmaengine.h>
>
> Looks like linux/dmaengine.h is not needed
>

I will drop it and update in V7 version.

> >
> >  #include "sdhci.h"
> >  #include "sdhci-uhs2.h"
> > @@ -794,6 +795,226 @@ static void sdhci_uhs2_finish_command(struct sdhci_host *host)
> >               __sdhci_finish_mrq(host, cmd->mrq);
> >  }
> >
> > +/*****************************************************************************\
> > + *                                                                           *
> > + * Request done                                                              *
> > + *                                                                           *
> > +\*****************************************************************************/
> > +
> > +static bool sdhci_uhs2_request_done(struct sdhci_host *host)
> > +{
> > +     unsigned long flags;
> > +     struct mmc_request *mrq;
> > +     int i;
> > +
> > +     spin_lock_irqsave(&host->lock, flags);
> > +
> > +     for (i = 0; i < SDHCI_MAX_MRQS; i++) {
> > +             mrq = host->mrqs_done[i];
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
> > +              * Do not finish until command and data lines are available for
> > +              * reset. Note there can only be one other mrq, so it cannot
> > +              * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> > +              * would both be null.
> > +              */
> > +             if (host->cmd || host->data_cmd) {
> > +                     spin_unlock_irqrestore(&host->lock, flags);
> > +                     return true;
> > +             }
> > +
> > +             /* Some controllers need this kick or reset won't work here */
> > +             if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> > +                     /* This is to force an update */
> > +                     host->ops->set_clock(host, host->clock);
>
> Let's not support SDHCI_QUIRK_CLOCK_BEFORE_RESET
>

I will drop it and update in V7 version.

> > +
> > +             sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +             host->pending_reset = false;
> > +     }
> > +
> > +     host->mrqs_done[i] = NULL;
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
> > +     struct sdhci_host *host = container_of(work, struct sdhci_host,
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
> > +/*****************************************************************************\
> > + *                                                                           *
> > + * Interrupt handling                                                        *
> > + *                                                                           *
> > +\*****************************************************************************/
> > +
> > +static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
> > +{
> > +     struct mmc_command *cmd = host->cmd;
> > +
> > +     DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
> > +         mmc_hostname(host->mmc), uhs2mask);
> > +
> > +     if (uhs2mask & SDHCI_UHS2_INT_CMD_ERR_MASK) {
> > +             if (!host->cmd) {
> > +                     pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +             host->cmd->error = -EILSEQ;
> > +             if (uhs2mask & SDHCI_UHS2_INT_CMD_TIMEOUT)
> > +                     host->cmd->error = -ETIMEDOUT;
> > +     }
> > +
> > +     if (uhs2mask & SDHCI_UHS2_INT_DATA_ERR_MASK) {
> > +             if (!host->data) {
> > +                     pr_err("%s: Got data interrupt 0x%08x but no data.\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     sdhci_dumpregs(host);
> > +                     return;
> > +             }
> > +
> > +             if (uhs2mask & SDHCI_UHS2_INT_DEADLOCK_TIMEOUT) {
> > +                     pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
> > +                            mmc_hostname(host->mmc),
> > +                            (unsigned int)uhs2mask);
> > +                     host->data->error = -ETIMEDOUT;
> > +             } else if (uhs2mask & SDHCI_UHS2_INT_ADMA_ERROR) {
> > +                     pr_err("%s: ADMA error = 0x %x\n",
> > +                            mmc_hostname(host->mmc),
> > +                            sdhci_readb(host, SDHCI_ADMA_ERROR));
> > +                     host->data->error = -EIO;
> > +             } else {
> > +                     host->data->error = -EILSEQ;
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
> > +     u32 mask = intmask, uhs2mask;
> > +
> > +     if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
>
> Please use sdhci_uhs2_mode()
>

I will update it in V7 version.

> > +             goto out;
> > +
> > +     if (intmask & SDHCI_INT_ERROR) {
> > +             uhs2mask = sdhci_readl(host, SDHCI_UHS2_INT_STATUS);
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
> > +             /* Caller, shdci_irq(), doesn't have to care UHS-2 errors */
>
> shdci -> sdhci
> care -> care about
>

I will update it in V7 version.

> > +             intmask &= ~SDHCI_INT_ERROR;
> > +             mask &= SDHCI_INT_ERROR;
> > +     }
> > +
> > +cmd_irq:
> > +     if (intmask & SDHCI_INT_CMD_MASK) {
> > +             /* Clear command interrupt */
> > +             sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
> > +
> > +             /* Handle command interrupt */
> > +             if (intmask & SDHCI_INT_RESPONSE)
> > +                     sdhci_uhs2_finish_command(host);
> > +
> > +             /* Caller, shdci_irq(), doesn't have to care UHS-2 command */
>
> shdci -> sdhci
> care -> care about
> command -> commands
>

I will update it in V7 version.

> > +             intmask &= ~SDHCI_INT_CMD_MASK;
> > +             mask &= SDHCI_INT_CMD_MASK;
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
> > +     struct sdhci_host *host = dev_id;
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
> > +     isr = host->thread_isr;
> > +     host->thread_isr = 0;
> > +
> > +     cmd = host->deferred_cmd;
> > +     if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
> > +             sdhci_finish_mrq(host, cmd->mrq);
> > +
> > +     spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +     if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> > +             struct mmc_host *mmc = host->mmc;
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
> >       struct sdhci_host *host = mmc_priv(mmc);
> > @@ -978,7 +1199,7 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> >       }
> >
> >       /* Init complete, do soft reset and enable UHS2 error irqs. */
> > -     host->ops->uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> > +     sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> >       sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK, SDHCI_UHS2_INT_ERROR_MASK);
> >       /*
> >        * N.B SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> > index 184fee80253c..64b7f356c9fc 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -179,5 +179,8 @@ bool sdhci_uhs2_mode(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
> >  void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
> > +void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
> > +int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
> > +u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index c547fc3b8b47..6c67b79102eb 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -47,6 +47,8 @@
> >  static unsigned int debug_quirks = 0;
> >  static unsigned int debug_quirks2;
> >
> > +static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
> > +
> >  void sdhci_dumpregs(struct sdhci_host *host)
> >  {
> >       SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
> > @@ -1256,11 +1258,12 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
> >       return ret;
> >  }
> >
> > -static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
> > -                                                struct mmc_data *data)
> > +struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
> > +                                         struct mmc_data *data)
> >  {
> >       return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_external_dma_channel);
>
> Does not need export
>

I will update it in V7 version.

> >
> >  int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd)
> >  {
> > @@ -1509,7 +1512,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
> >       sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
> >  }
> >
> > -static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
> > +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
> >  {
> >       return (!(host->flags & SDHCI_DEVICE_DEAD) &&
> >               ((mrq->cmd && mrq->cmd->error) ||
> > @@ -1517,8 +1520,9 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
> >                (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
> >                (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_needs_reset);
> >
> > -static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
> > +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
> >  {
> >       int i;
> >
> > @@ -1538,6 +1542,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
> >
> >       WARN_ON(i >= SDHCI_MAX_MRQS);
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_set_mrq_done);
> >
> >  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
> >  {
> > @@ -3122,6 +3127,55 @@ static const struct mmc_host_ops sdhci_ops = {
> >   *                                                                           *
> >  \*****************************************************************************/
> >
> > +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
> > +{
> > +     struct mmc_data *data = mrq->data;
> > +
> > +     if (data && data->host_cookie == COOKIE_MAPPED) {
> > +             if (host->bounce_buffer) {
> > +                     /*
> > +                      * On reads, copy the bounced data into the
> > +                      * sglist
> > +                      */
> > +                     if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
> > +                             unsigned int length = data->bytes_xfered;
> > +
> > +                             if (length > host->bounce_buffer_size) {
> > +                                     pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
> > +                                            mmc_hostname(host->mmc),
> > +                                            host->bounce_buffer_size,
> > +                                            data->bytes_xfered);
> > +                                     /* Cap it down and continue */
> > +                                     length = host->bounce_buffer_size;
> > +                             }
> > +                             dma_sync_single_for_cpu(
> > +                                     host->mmc->parent,
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
> > +             data->host_cookie = COOKIE_UNMAPPED;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
> > +
> >  static bool sdhci_request_done(struct sdhci_host *host)
> >  {
> >       unsigned long flags;
> > @@ -3186,48 +3240,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >                       sdhci_set_mrq_done(host, mrq);
> >               }
> >
> > -             if (data && data->host_cookie == COOKIE_MAPPED) {
> > -                     if (host->bounce_buffer) {
> > -                             /*
> > -                              * On reads, copy the bounced data into the
> > -                              * sglist
> > -                              */
> > -                             if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
> > -                                     unsigned int length = data->bytes_xfered;
> > -
> > -                                     if (length > host->bounce_buffer_size) {
> > -                                             pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
> > -                                                    mmc_hostname(host->mmc),
> > -                                                    host->bounce_buffer_size,
> > -                                                    data->bytes_xfered);
> > -                                             /* Cap it down and continue */
> > -                                             length = host->bounce_buffer_size;
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
> > -                                     /* No copying, just switch ownership */
> > -                                     dma_sync_single_for_cpu(
> > -                                             mmc_dev(host->mmc),
> > -                                             host->bounce_addr,
> > -                                             host->bounce_buffer_size,
> > -                                             mmc_get_dma_dir(data));
> > -                             }
> > -                     } else {
> > -                             /* Unmap the raw data */
> > -                             dma_unmap_sg(mmc_dev(host->mmc), data->sg,
> > -                                          data->sg_len,
> > -                                          mmc_get_dma_dir(data));
> > -                     }
> > -                     data->host_cookie = COOKIE_UNMAPPED;
> > -             }
> > +             sdhci_request_done_dma(host, mrq);
> >       }
> >
> >       host->mrqs_done[i] = NULL;
> > @@ -3242,7 +3255,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
> >       return false;
> >  }
> >
> > -static void sdhci_complete_work(struct work_struct *work)
> > +void sdhci_complete_work(struct work_struct *work)
> >  {
> >       struct sdhci_host *host = container_of(work, struct sdhci_host,
> >                                              complete_work);
> > @@ -3250,6 +3263,7 @@ static void sdhci_complete_work(struct work_struct *work)
> >       while (!sdhci_request_done(host))
> >               ;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_complete_work);
> >
> >  static void sdhci_timeout_timer(struct timer_list *t)
> >  {
> > @@ -3705,7 +3719,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
> >       return result;
> >  }
> >
> > -static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> > +irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> >  {
> >       struct sdhci_host *host = dev_id;
> >       struct mmc_command *cmd;
> > @@ -3735,6 +3749,7 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> >
> >       return IRQ_HANDLED;
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_thread_irq);
> >
> >  /*****************************************************************************\
> >   *                                                                           *
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 3b87fcae1294..4979af7cabca 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -840,7 +840,10 @@ int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd);
> >  void sdhci_external_dma_release(struct sdhci_host *host);
> >  void __sdhci_external_dma_prepare_data(struct sdhci_host *host, struct mmc_command *cmd);
> >  void sdhci_external_dma_pre_transfer(struct sdhci_host *host, struct mmc_command *cmd);
> > +struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data);
>
> Does not need export
>

I will update it in V7 version.

> >  #endif
> > +bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
> > +void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq);
> >  void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> >  void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> >  void __sdhci_finish_data_common(struct sdhci_host *host);
> > @@ -870,6 +873,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
> >  void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
> > +void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
> > +void sdhci_complete_work(struct work_struct *work);
> > +irqreturn_t sdhci_thread_irq(int irq, void *dev_id);
> >  void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
> >                          dma_addr_t addr, int len, unsigned int cmd);
> >
>

Thanks, Victor Shih
