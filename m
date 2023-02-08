Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7047568F211
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBHPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjBHPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:31:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CF2B288
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:31:24 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be8so19658185plb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T211bL5EZaKFL1JIVqIkDDvlLcpYTDv8aw1jMIM3ddU=;
        b=emx8hnoo6waua0yNFlq2PshMPgR2aVm9J0gMXOZGCggf1CV9DMpz/aULMOoa2cj9Mo
         I86kjuAtHL0HMV//7Hvw7WuvoLZvfW0t4ga31aA+rJi6BQ/z1ZevUwzakkY1rm++aYHZ
         WOyWPxZvw/VXBHxPSYzow5dXJaIGALHm/uljYBKCnQZdfgtbsENLHTDSgToNU4x5+dji
         VhdhN46zJQ5m3CBb8VrQMgpDvhJ/rWcjKMgNLAeNuYuMa5Pdi67vA5U0azktnzqRISKG
         4+AfXPYgIPoFigAboNVA2vKlQKKgPYFZ1HrWeizXx6DcEfKbmJE/4E7fog+MvNI/q3Op
         +2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T211bL5EZaKFL1JIVqIkDDvlLcpYTDv8aw1jMIM3ddU=;
        b=kh/CgOzkQKaDcYpJZm2dzRohfg0kpWVmAbXnoHeEcMB9D8Sgsq5wZreGP/tiyBs9Md
         EDNLxCfDPpupO7bJTwuuVmGLw3i1IfQH1fdHSX3pDNHg0nAdzhVEMGH4W6L2EIxCTkU4
         YlcE8/5XInhEXrz7HYG2KK33RQ6eE5YxFznXf0PBu7bIeIus8C0sIqHzReySlS17WL60
         eCIXSJUT+DZYcQLBPzmZ6pnU9ebD5OWs2sIJS3ubuX8vRA1f369deMqgXhMf1lvqIptU
         BgobpG5tFGgTG8bMLRQ9g8BGdoEFhJMY0qSA4FyrODWkzgMIWaiNlLKff53Vca/2RehI
         deSg==
X-Gm-Message-State: AO0yUKWm6uS+JRi3/ZxgPEeVxjzZkm06CM7nyCb7OlQFljtv92YM0lFT
        wPd2e5XWD++TdiSNYk6BWBstCoQJkSi4ltCfOXBGhw==
X-Google-Smtp-Source: AK7set99TxVanhwLgV4b5bKtfG47ly/88Ps39Fg1DbGNG37gjIj/P7GjCu6bcP0ZIJjZXL7T21miE1YZ37jL97BsFRw=
X-Received: by 2002:a17:90a:fa8c:b0:230:f42f:99c2 with SMTP id
 cu12-20020a17090afa8c00b00230f42f99c2mr826270pjb.32.1675870283252; Wed, 08
 Feb 2023 07:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw> <20221213090047.3805-7-victor.shih@genesyslogic.com.tw>
In-Reply-To: <20221213090047.3805-7-victor.shih@genesyslogic.com.tw>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Feb 2023 16:30:46 +0100
Message-ID: <CAPDyKFoV3Ch-xzXxiT2RnDeLvsO454Pwq1vQL_bdNLptM+amAg@mail.gmail.com>
Subject: Re: [PATCH V6 06/24] mmc: core: Support UHS-II card control and access
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"On Tue, 13 Dec 2022 at 10:01, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Embed UHS-II access/control functionality into the MMC request
> processing flow.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/core/block.c   |    6 +-
>  drivers/mmc/core/core.c    |   20 +
>  drivers/mmc/core/mmc_ops.c |   25 +-
>  drivers/mmc/core/mmc_ops.h |    1 +
>  drivers/mmc/core/sd.c      |   11 +-
>  drivers/mmc/core/sd.h      |    3 +
>  drivers/mmc/core/sd_ops.c  |   13 +
>  drivers/mmc/core/sd_ops.h  |    3 +
>  drivers/mmc/core/sd_uhs2.c | 1171 +++++++++++++++++++++++++++++++++++-
>  9 files changed, 1206 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 20da7ed43e6d..d3e8ec43cdd5 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1596,6 +1596,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>         struct request *req = mmc_queue_req_to_req(mqrq);
>         struct mmc_blk_data *md = mq->blkdata;
>         bool do_rel_wr, do_data_tag;
> +       bool do_multi;
> +
> +       do_multi = (card->uhs2_state & MMC_UHS2_INITIALIZED) ? true : false;
>
>         mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data_tag);
>
> @@ -1606,7 +1609,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                 brq->cmd.arg <<= 9;
>         brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>
> -       if (brq->data.blocks > 1 || do_rel_wr) {
> +       if (brq->data.blocks > 1 || do_rel_wr || do_multi) {

This looks wrong to me. UHS2 can use single block read/writes too. Right?

>                 /* SPI multiblock writes terminate using a special
>                  * token, not a STOP_TRANSMISSION request.
>                  */
> @@ -1619,6 +1622,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                 brq->mrq.stop = NULL;
>                 readcmd = MMC_READ_SINGLE_BLOCK;
>                 writecmd = MMC_WRITE_BLOCK;
> +               brq->cmd.uhs2_tmode0_flag = 1;

As "do_multi" is always set for UHS2, setting this flag here seems to
be wrong/redundant.

Anyway, if I understand correctly, the flag is intended to be used to
inform the host driver whether the so-called 2L_HD_mode (half-duplex
or full-duplex) should be used for the I/O request or not.

To fix the above behaviour, I suggest we try to move the entire
control of the flag into mmc_uhs2_prepare_cmd(). We want the flag to
be set for multi block read/writes (CMD18 and CMD25), but only if the
host and card supports the 2L_HD_mode too. According to my earlier
suggestions, we should be able to check that via the bits we set
earlier in the ios->timing.

Moreover, by making mmc_uhs2_prepare_cmd() responsible for setting the
flag, I think we can also move the definition of the flag into the
struct uhs2_command. While at it, I suggest we also rename the flag
into "tmode_half_duplex", to better describe its purpose, which also
means the interpretation of the flag becomes inverted.

>         }
>         brq->cmd.opcode = rq_data_dir(req) == READ ? readcmd : writecmd;
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index ad1a40446813..01f8216885ad 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -334,6 +334,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
>
>  int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  {
> +       struct uhs2_command uhs2_cmd;
> +       __be32 payload[4]; /* for maximum size */
>         int err;
>
>         init_completion(&mrq->cmd_completion);
> @@ -351,6 +353,14 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>         if (err)
>                 return err;
>
> +       if (host->card) {
> +               if (host->card->uhs2_state & MMC_UHS2_INITIALIZED) {
> +                       uhs2_cmd.payload = payload;
> +                       mrq->cmd->uhs2_cmd = &uhs2_cmd;
> +                       mmc_uhs2_prepare_cmd(host, mrq);
> +               }
> +       }

To avoid open coding, please move this into mmc_mrq_prep() or add a
new helper function for it.

> +
>         led_trigger_event(host->led, LED_FULL);
>         __mmc_start_request(host, mrq);
>
> @@ -430,6 +440,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
>   */
>  int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
> +       struct uhs2_command uhs2_cmd;
> +       __be32 payload[4]; /* for maximum size */
>         int err;
>
>         /*
> @@ -450,6 +462,14 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
>         if (err)
>                 goto out_err;
>
> +       if (host->card) {
> +               if (host->card->uhs2_state & MMC_UHS2_INITIALIZED) {
> +                       uhs2_cmd.payload = payload;
> +                       mrq->cmd->uhs2_cmd = &uhs2_cmd;
> +                       mmc_uhs2_prepare_cmd(host, mrq);
> +               }
> +       }

Ditto.

> +
>         err = host->cqe_ops->cqe_request(host, mrq);
>         if (err)
>                 goto out_err;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 81c55bfd6e0c..daa1f4ccd99a 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -144,10 +144,24 @@ int mmc_set_dsr(struct mmc_host *host)
>         return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
>  }
>
> +int __mmc_go_idle(struct mmc_host *host)
> +{
> +       struct mmc_command cmd = {};
> +       int err;
> +
> +       cmd.opcode = MMC_GO_IDLE_STATE;
> +       cmd.arg = 0;
> +       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
> +
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       mmc_delay(1);
> +
> +       return err;
> +}
> +
>  int mmc_go_idle(struct mmc_host *host)
>  {
>         int err;
> -       struct mmc_command cmd = {};
>
>         /*
>          * Non-SPI hosts need to prevent chipselect going active during
> @@ -163,13 +177,7 @@ int mmc_go_idle(struct mmc_host *host)
>                 mmc_delay(1);
>         }
>
> -       cmd.opcode = MMC_GO_IDLE_STATE;
> -       cmd.arg = 0;
> -       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
> -
> -       err = mmc_wait_for_cmd(host, &cmd, 0);
> -
> -       mmc_delay(1);
> +       err = __mmc_go_idle(host);

The above changes for mmc_go_idle() are pure refactorings, please move
these changes into a separate patch that precedes $subject patch.

This will help to simplify the review.

>
>         if (!mmc_host_is_spi(host)) {
>                 mmc_set_chip_select(host, MMC_CS_DONTCARE);
> @@ -300,6 +308,7 @@ int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
>          * not R1 plus a data block.
>          */
>         cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +       cmd.uhs2_tmode0_flag = 1;

As I stated above, I think we can drop this and rather manage the flag
from mmc_uhs2_prepare_cmd() instead. From now on, I will stop to
comment more on the use of the uhs2_tmode0_flag, as the similar
comments applies to more places.

[...]

> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index 3ba7b3cf4652..29c802dec988 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>
>  struct mmc_card;
> +struct mmc_command;

Looks like this should be "struct mmc_request;" instead.

>  struct mmc_host;
>
>  int mmc_app_set_bus_width(struct mmc_card *card, int width);
> @@ -19,10 +20,12 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
>  int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr);
>  int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
>  int mmc_app_send_scr(struct mmc_card *card);
> +int mmc_decode_scr(struct mmc_card *card);
>  int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>         u8 value, u8 *resp);
>  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> +void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq);
>
>  #endif
>
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index 800957f74632..a79eb08ec540 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -1,48 +1,125 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (C) 2021 Linaro Ltd
> - *
>   * Author: Ulf Hansson <ulf.hansson@linaro.org>
>   *
> + * Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + * Author: Yi Sun <yi.y.sun@intel.com>
> + *
> + * Copyright (C) 2020 Genesys Logic, Inc.
> + * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> + *
> + * Copyright (C) 2020 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * Copyright (C) 2022 Genesys Logic, Inc.
> + * Authors: Jason Lai <jason.lai@genesyslogic.com.tw>
> + *
>   * Support for SD UHS-II cards
>   */
>  #include <linux/err.h>
> +#include <linux/pm_runtime.h>
>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sd_uhs2.h>
>
> +#include "card.h"
>  #include "core.h"
>  #include "bus.h"
>  #include "sd.h"
> +#include "sd_ops.h"
>  #include "mmc_ops.h"
>
> +#define UHS2_WAIT_CFG_COMPLETE_PERIOD_US       (1 * 1000)      /* 1ms */
> +#define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS      100             /* 100ms */
> +
>  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
> +int sd_uhs2_reinit(struct mmc_host *host);

This should be static - and please don't use forward declaration,
unless it's really necessary.

>
> -static int sd_uhs2_set_ios(struct mmc_host *host)
> +/*
> + * Internal function that does the actual ios call to the host driver,
> + * optionally printing some debug output.
> + */
> +static inline int sd_uhs2_set_ios(struct mmc_host *host)
>  {
>         struct mmc_ios *ios = &host->ios;
>
> +       pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> +                mmc_hostname(host), ios->clock, ios->power_mode, ios->vdd, ios->timing);
> +
>         return host->ops->uhs2_set_ios(host, ios);

I have made some more thinking around the uhs2 host callbacks.

As we are using the ->uhs2_control() callback for all the other uhs2
operations, it seems silly to have a separate callback for the ios. In
other words, I suggest that we drop the ->uhs2_set_ios() callback
altogether and replace the two users of the above function with direct
calls to the ->uhs2_control() callback. See more below.

>  }
>
>  static int sd_uhs2_power_up(struct mmc_host *host)
>  {
> +       int err;
> +
> +       if (host->ios.power_mode == MMC_POWER_ON)
> +               return 0;
> +
>         host->ios.vdd = fls(host->ocr_avail) - 1;
>         host->ios.clock = host->f_init;
>         host->ios.timing = MMC_TIMING_SD_UHS2;
> -       host->ios.power_mode = MMC_POWER_UP;
> +       host->ios.power_mode = MMC_POWER_ON;
>
> -       return sd_uhs2_set_ios(host);
> +       err = sd_uhs2_set_ios(host);

As stated above, I suggest we replace the above call with:
err = host->ops->uhs2_control(host, UHS2_SET_IOS);

> +
> +       mmc_delay(host->uhs2_ios.power_delay_ms);
> +
> +       return err;
>  }
>
> -static void sd_uhs2_power_off(struct mmc_host *host)
> +static int sd_uhs2_power_off(struct mmc_host *host)
>  {
> +       if (host->ios.power_mode == MMC_POWER_OFF)
> +               return 0;
> +
>         host->ios.vdd = 0;
>         host->ios.clock = 0;
>         host->ios.timing = MMC_TIMING_LEGACY;
>         host->ios.power_mode = MMC_POWER_OFF;
>
> -       sd_uhs2_set_ios(host);
> +       return sd_uhs2_set_ios(host);

Similar to the above, I suggest we replace the above call with:
return host->ops->uhs2_control(host, UHS2_SET_IOS);

>
>  /*
> @@ -61,6 +146,88 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
>   */
>  static int sd_uhs2_dev_init(struct mmc_host *host)
>  {
> +       struct mmc_command cmd = {0};
> +       struct uhs2_command uhs2_cmd = {};
> +       u32 cnt;
> +       u32 dap, gap, resp_gap;
> +       u16 header, arg;
> +       __be32 payload[UHS2_DEV_INIT_PAYLOAD_LEN];
> +       u8 gd = 0;
> +       u8 resp[UHS2_DEV_ENUM_RESP_LEN] = {0};
> +       int err;
> +
> +       dap = host->uhs2_caps.dap;
> +       gap = host->uhs2_caps.gap;
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 Figure 6-21 to see DEVICE_INIT CCMD format.
> +        * Head:
> +        *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
> +        *      - IOADR = CMD_BASE + 002h
> +        * Payload:
> +        *      - bit [3:0]  : GAP(Group Allocated Power)
> +        *      - bit [7:4]  : GD(Group Descriptor)
> +        *      - bit [11]   : Complete Flag
> +        *      - bit [15:12]: DAP(Device Allocated Power)
> +        */
> +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> +       arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_4B |
> +              (UHS2_DEV_CMD_DEVICE_INIT >> 8);
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 section 6.3.1.
> +        * Max. time from DEVICE_INIT CCMD EOP reception on Device
> +        * Rx to its SOP transmission on Device Tx(Tfwd_init_cmd) is
> +        * 1 second.
> +        */
> +       cmd.busy_timeout = 1000;
> +
> +       /*
> +        * Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
> +        * When the number of the DEVICE_INIT commands is reach to
> +        * 30 tiems, Host shall stop issuing DEVICE_INIT command
> +        * and regard it as an error.
> +        */
> +       for (cnt = 0; cnt < 30; cnt++) {
> +               payload[0] = ((dap & 0xF) << 12) |
> +                             UHS2_DEV_INIT_COMPLETE_FLAG |
> +                             ((gd & 0xF) << 4) |
> +                             (gap & 0xF);
> +
> +               sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
> +                                    payload, UHS2_DEV_INIT_PAYLOAD_LEN,
> +                                    resp, UHS2_DEV_INIT_RESP_LEN);
> +
> +               err = mmc_wait_for_cmd(host, &cmd, 0);
> +

Nitpick: Unnecessary line break.

> +               if (err) {
> +                       pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +                              mmc_hostname(host), __func__, err);
> +                       return err;
> +               }
> +
> +               if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
> +                       pr_err("%s: DEVICE_INIT response is wrong!\n",
> +                              mmc_hostname(host));
> +                       return -EIO;
> +               }
> +
> +               if (resp[5] & 0x8) {
> +                       host->uhs2_caps.group_desc = gd;
> +                       return 0;
> +               }
> +               resp_gap = resp[4] & 0x0F;
> +               if (gap == resp_gap)
> +                       gd++;
> +       }
> +       if (cnt == 30) {

There is no need to check cnt here. It's always 30 if we reach this point.

> +               pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
> +                      mmc_hostname(host));
> +               return -EIO;
> +       }
> +
>         return 0;
>  }

[...]

>  static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>  {
> +       struct mmc_command cmd = {0};
> +       struct uhs2_command uhs2_cmd = {};
> +       u16 header, arg;
> +       __be32 payload[UHS2_CFG_WRITE_PAYLOAD_LEN];
> +       u8 nMinDataGap;
> +       int err;
> +       u8 resp[5] = {0};
> +
> +       /*
> +        * Use Control Write CCMD to set Generic Setting in Configuration Register.
> +        * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +        * - IOADR = Generic Setting Register(CFG_BASE + 008h)
> +        * - Payload = New contents to be written to Generic Setting Register
> +        */
> +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
> +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_8B |
> +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +       if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> +           host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> +               /* Support HD */
> +               host->uhs2_ios.is_2L_HD_mode = true;
> +               nMinDataGap = 1;
> +       } else {
> +               /* Only support 2L-FD so far */
> +               host->uhs2_ios.is_2L_HD_mode = false;
> +               nMinDataGap = 3;
> +       }
> +
> +       /*
> +        * Most UHS-II cards only support FD and 2L-HD mode. Other lane numbers
> +        * defined in UHS-II addendem Ver1.01 are optional.
> +        */
> +       host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +       card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +
> +       payload[0] = card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N_LANES_POS;
> +       payload[1] = 0;
> +       payload[0] = cpu_to_be32(payload[0]);
> +       payload[1] = cpu_to_be32(payload[1]);
> +
> +       /*
> +        * There is no payload because per spec, there should be
> +        * no payload field for read CCMD.
> +        * Plen is set in arg. Per spec, plen for read CCMD
> +        * represents the len of read data which is assigned in payload
> +        * of following RES (p136).
> +        */
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_CFG_WRITE_PAYLOAD_LEN,
> +                            NULL, 0);
> +
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * Use Control Write CCMD to set PHY Setting in Configuration Register.
> +        * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +        * - IOADR = PHY Setting Register(CFG_BASE + 00Ah)
> +        * - Payload = New contents to be written to PHY Setting Register
> +        */
> +       arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_8B |
> +              (UHS2_DEV_CONFIG_PHY_SET >> 8);
> +
> +       if (host->uhs2_caps.speed_range == UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
> +               card->uhs2_state |= MMC_UHS2_SPEED_B;

As I suggested earlier, let's set a corresponding bit in ios->timing instead.

> +               card->uhs2_config.speed_range_set =
> +                                       UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
> +       } else {
> +               card->uhs2_config.speed_range_set = UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
> +               card->uhs2_state &= ~MMC_UHS2_SPEED_B;

As I suggested earlier, I think it should be sufficient to clear this
in sd_uhs2_power_off() (by resetting ios->timing).

> +       }
> +
> +       payload[0] = card->uhs2_config.speed_range_set << UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
> +
> +       card->uhs2_config.n_lss_sync_set = (max(card->uhs2_config.n_lss_sync,
> +                                               host->uhs2_caps.n_lss_sync) >> 2) &
> +                                          UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
> +       host->uhs2_caps.n_lss_sync_set = card->uhs2_config.n_lss_sync_set;
> +
> +       card->uhs2_config.n_lss_dir_set = (max(card->uhs2_config.n_lss_dir,
> +                                              host->uhs2_caps.n_lss_dir) >> 3) &
> +                                         UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +       host->uhs2_caps.n_lss_dir_set = card->uhs2_config.n_lss_dir_set;
> +
> +       payload[1] = (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
> +                    card->uhs2_config.n_lss_sync_set;
> +       payload[0] = cpu_to_be32(payload[0]);
> +       payload[1] = cpu_to_be32(payload[1]);
> +
> +       memset(resp, 0, sizeof(resp));
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_CFG_WRITE_PAYLOAD_LEN,
> +                            resp, UHS2_CFG_WRITE_PHY_SET_RESP_LEN);
> +
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       if ((resp[2] & 0x80)) {
> +               pr_err("%s: %s: UHS2 CMD not accepted, resp= 0x%x!\n",
> +                      mmc_hostname(host), __func__, resp[2]);
> +               return -EIO;
> +       }
> +
> +       /*
> +        * Use Control Write CCMD to set LINK/TRAN Setting in Configuration Register.
> +        * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +        * - IOADR = LINK/TRAN Setting Register(CFG_BASE + 00Ch)
> +        * - Payload = New contents to be written to LINK/TRAN Setting Register
> +        */
> +       arg = ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
> +               UHS2_NATIVE_CMD_WRITE |
> +               UHS2_NATIVE_CMD_PLEN_8B |
> +               (UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
> +
> +       if (card->uhs2_config.app_type == UHS2_DEV_CONFIG_APP_SD_MEM)
> +               card->uhs2_config.maxblk_len_set = UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN;
> +       else
> +               card->uhs2_config.maxblk_len_set = min(card->uhs2_config.maxblk_len,
> +                                                      host->uhs2_caps.maxblk_len);
> +       host->uhs2_caps.maxblk_len_set = card->uhs2_config.maxblk_len_set;
> +
> +       card->uhs2_config.n_fcu_set = min(card->uhs2_config.n_fcu, host->uhs2_caps.n_fcu);
> +       host->uhs2_caps.n_fcu_set = card->uhs2_config.n_fcu_set;
> +
> +       card->uhs2_config.n_data_gap_set = max(nMinDataGap, card->uhs2_config.n_data_gap);
> +       host->uhs2_caps.n_data_gap_set = card->uhs2_config.n_data_gap_set;
> +
> +       host->uhs2_caps.max_retry_set = 3;
> +       card->uhs2_config.max_retry_set = host->uhs2_caps.max_retry_set;
> +
> +       payload[0] = (card->uhs2_config.maxblk_len_set << UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
> +                    (card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
> +                    (card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FCU_POS);
> +       payload[1] = card->uhs2_config.n_data_gap_set;
> +       payload[0] = cpu_to_be32(payload[0]);
> +       payload[1] = cpu_to_be32(payload[1]);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_CFG_WRITE_PAYLOAD_LEN,
> +                            NULL, 0);
> +
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * Use Control Write CCMD to set Config Completion(payload bit 63) in Generic Setting
> +        * Register.
> +        * Header:
> +        *      - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
> +        *      - IOADR = PGeneric Setting Register(CFG_BASE + 008h)
> +        * Payload:
> +        *      - bit [63]: Config Completion
> +        *
> +        * DLSM transits to Active state immediately when Config Completion is set to 1.
> +        */
> +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +              UHS2_NATIVE_CMD_WRITE |
> +              UHS2_NATIVE_CMD_PLEN_8B |
> +              (UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +       payload[0] = 0;
> +       payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
> +       payload[0] = cpu_to_be32(payload[0]);
> +       payload[1] = cpu_to_be32(payload[1]);
> +
> +       memset(resp, 0, sizeof(resp));
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_CFG_WRITE_PAYLOAD_LEN,
> +                            resp, UHS2_CFG_WRITE_GENERIC_SET_RESP_LEN);
> +
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /* Set host Config Setting registers */
> +       err = host->ops->uhs2_control(host, UHS2_SET_CONFIG);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 SET_CONFIG fail!\n", mmc_hostname(host), __func__);
> +               return err;
> +       }
> +
> +       return 0;
> +}

[...]

> +static int sd_uhs2_change_speed(struct mmc_host *host, u32 node_id)
> +{
> +       struct mmc_command cmd = {0};
> +       struct uhs2_command uhs2_cmd = {};
> +       u16 header, arg;
> +       int err;
> +       struct sd_uhs2_wait_active_state_data cb_data = {
> +               .host = host,
> +               .cmd = &cmd
> +       };
> +
> +       /* Change Speed Range at controller side. */
> +       err = host->ops->uhs2_control(host, UHS2_SET_SPEED_B);

As I asked for in patch5, is this call really needed for sdhci?

> +       if (err) {
> +               pr_err("%s: %s: UHS2 SET_SPEED fail!\n", mmc_hostname(host), __func__);
> +               return err;
> +       }
> +
> +       err = sd_uhs2_go_dormant(host, node_id);
> +       if (err) {
> +               pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /*
> +        * Use Control Read CCMD to check Config Completion(bit 63) in Generic Setting Register.
> +        * - Control Read(R/W=0) with 8-Byte payload(PLEN=10b).
> +        * - IOADR = Generic Setting Register(CFG_BASE + 008h)
> +        *
> +        * When UHS-II card been switched to new speed mode, it will set Config Completion to 1.
> +        */
> +       header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
> +       arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +               UHS2_NATIVE_CMD_READ |
> +               UHS2_NATIVE_CMD_PLEN_8B |
> +               (UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +       sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> +       err = __mmc_poll_for_busy(host, UHS2_WAIT_CFG_COMPLETE_PERIOD_US,
> +                                 UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS,
> +                                 &__sd_uhs2_wait_active_state_cb, &cb_data);
> +       if (err) {
> +               pr_err("%s: %s: Not switch to Active in 100 ms\n", mmc_hostname(host), __func__);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sd_uhs2_get_ro(struct mmc_host *host)
> +{
> +       /*
> +        * Some systems don't feature a write-protect pin and don't need one.
> +        * E.g. because they only have micro-SD card slot. For those systems
> +        * assume that the SD card is always read-write.
> +        */
> +       if (host->caps2 & MMC_CAP2_NO_WRITE_PROTECT)
> +               return 0;
> +
> +       if (!host->ops->get_ro)
> +               return -1;
> +
> +       return host->ops->get_ro(host);

Let's avoid the open coding and use mmc_sd_get_ro() instead.

> +}
> +
> +/*
> + * Mask off any voltages we don't support and select
> + * the lowest voltage
> + */
> +u32 sd_uhs2_select_voltage(struct mmc_host *host, u32 ocr)
> +{
> +       int bit;
> +       int err;
> +
> +       /*
> +        * Sanity check the voltages that the card claims to
> +        * support.
> +        */
> +       if (ocr & 0x7F) {
> +               dev_warn(mmc_dev(host), "card claims to support voltages below defined range\n");
> +               ocr &= ~0x7F;
> +       }
> +
> +       ocr &= host->ocr_avail;
> +       if (!ocr) {
> +               dev_warn(mmc_dev(host), "no support for card's volts\n");
> +               return 0;
> +       }
> +
> +       if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
> +               bit = ffs(ocr) - 1;
> +               ocr &= 3 << bit;
> +               /* Power cycle */
> +               err = sd_uhs2_power_off(host);
> +               if (err)
> +                       return 0;
> +               err = sd_uhs2_reinit(host);

As also pointed out by Adrian, this path becomes circular and doesn't
work as expected.

At this point, I would prefer to keep things as simple as possible, so
I suggest that we drop this path entirely for UHS2.

> +               if (err)
> +                       return 0;
> +       } else {
> +               bit = fls(ocr) - 1;
> +               ocr &= 3 << bit;

Note that, in mmc_select_voltage() the corresponding code has been
updated in commit 39a72dbfe188 ("mmc: core: properly select voltage
range without power cycle") that fixes a real problem for us.

By taking the above observations into consideration, it looks like it
may be better to reuse mmc_select_voltage() for UHS-II after all. To
prevent the power cycle path for UHS-II, we can just add a check for
the ios->timings in there. That should work, I think.

> +               if (bit != host->ios.vdd)
> +                       dev_warn(mmc_dev(host), "exceeding card's volts\n");
> +       }
> +
> +       return ocr;
> +}
> +
>  /*
>   * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
>   * commands/requests to be backwards compatible through the legacy SD protocol.
> @@ -107,14 +893,149 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>   */
>  static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)

I decided to postpone the review of the following parts below, which
consists of the legacy card initialization (SD-tran) and the
power-management support - as it looks like there are enough for you
to work on for a while.

Let me also ask about the power management support - did you test the
system suspend/resume path? Just to understand, if this is more an
attempt to make it work or whether it's actually tested/works?

[...]

Kind regards
Uffe
