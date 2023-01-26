Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2B67CF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjAZPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjAZPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:15:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88877CC0B;
        Thu, 26 Jan 2023 07:15:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso6332358pju.0;
        Thu, 26 Jan 2023 07:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UK/KO+wLSCJQGRF+KqFju1NGMMUsJhybtbcsoOymHO8=;
        b=qOl/kGq2AdAloM0gvuTunEhcToCpwaZHelXm8ZrKpim3nF6v60UgYGCHDsFFQJp9Pz
         BIhUZXpsDiyEI1IuvPOOXyZpKMJrawabNmzHNzGNdbxON6C+vJk3Y3e+9GA1YZJmPemw
         dyZUKvpyFLBn2r9NGxruiqPCJIRbaQVYY6YC1KhxqDESZFr4Yj+qUFC04BKwSEfNwnYS
         iL1JmaieDcosdSQEIumPHdJLd/YV4JB9LSu4nJ5avhpQolis2uC2bPjrhtv48kysV/yb
         kYJcHwPj2/zrZvB19VGfTxokHoI+i1GFcTSembdZgTU8XRJ2PdnmJvj56/aPPg+YzOx0
         8VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK/KO+wLSCJQGRF+KqFju1NGMMUsJhybtbcsoOymHO8=;
        b=g2NhY2qko4vzVUJM0Q0fjq/jkmIm85ZXd+gzb06kKCyL2l9tzHbU7MeuwkOE1sRDXU
         ImTrXdxRvSYqtJhW/68l9wJYvcJ5i9UWvwFPCrBflsda03MTelDhAg3DewgzimOdfFGT
         V6k+7x/2H5kKLQ6S16pZB7HXOzafDFXXHRAMpQE2BgDkQpF2VV40bDGOBb/j0c6gzS8R
         sEaFO4YkOOGQXNzXCnuhP09f7kWLf6C0mWNhvRvrfwrST2VcFKk1+gfZlilfB5w2DGNw
         HHcWfZ6qRW6ifUsQ5aq3Ns1kvsqHhfvZcMWhd/WD9uEDKoIJ9yHb/UCJh9Ax219W+1jn
         29CQ==
X-Gm-Message-State: AFqh2krSICILM03U0Ocx09w8P+BWtGLnQCjcG2jcqOXQBFCjF0H3VrQp
        x4LDTPLhWhzpk02bnh5bq11R6yUOpaW7L0w4SV5hxbyn9u4=
X-Google-Smtp-Source: AMrXdXv58exgZ3063BpH8iweX1XWUcl4BQYkYTQtaVXNITVsKa/ejXocF7XSlwlEqSmXbuOck0YY2jexxUk/WFeP2pA=
X-Received: by 2002:a17:90b:291:b0:227:3f:57be with SMTP id
 az17-20020a17090b029100b00227003f57bemr5726139pjb.158.1674746113844; Thu, 26
 Jan 2023 07:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20230124221218.341511-1-william.zhang@broadcom.com> <20230124221218.341511-11-william.zhang@broadcom.com>
In-Reply-To: <20230124221218.341511-11-william.zhang@broadcom.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 26 Jan 2023 16:15:00 +0100
Message-ID: <CAOiHx=nfKnXwhYKfuQP4KKT-URfAg4jz-8QOh8EP3L=mvc=pUQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] spi: bcm63xx-hsspi: Add prepend mode support
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
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

On Tue, 24 Jan 2023 at 23:33, William Zhang <william.zhang@broadcom.com> wrote:
>
> Due to the controller limitation to keep the chip select low during the
> bus idle time between the transfer, a dummy cs workaround was used when
> this driver was first upstreamed to the kernel.  It basically picks the
> dummy cs as !actual_cs so typically dummy cs is 1 when most of the case
> only cs 0 is used in the board design. Then invert the polarity of both
> cs and tell the controller to start the transfers using dummy cs.
> Assuming both cs are active low before the inversion, effectively this
> keeps dummy cs high and actual cs low during the transfer and workaround
> the issue.
>
> This workaround implies that dummy cs 1 pin has to be set to chip
> selection function in the pinmux when the transfer clock is above
> 25MHz. The old chips likely have default pinmux set to chip select on
> the dummy cs pin so it works but this is not case for the new Broadband
> BCA chips and this workaround stop working. This is specifically an
> issue to support SPI NAND and SPI NOR flash because these flash devices
> can typically run at or above 100MHz.
>
> This patch utilizes the prepend feature of the controller to combine the
> multiple transfers in the same message to a single transfer when
> possible. This way there is no need to keep clock low between transfers
> and solve the issue without any hardware requirement.
>
> Multiple transfers within a SPI message may be combined into one
> transfer if the following are all true:
>   * One or more half duplex write transfer in single bit mode
>   * Optional full duplex read/write at the end
>   * No delay and cs_change between transfers
>
> Most of the SPI device meets this requirements such as SPI NOR,
> SPI NAND flash, Broadcom SPI voice card and etc. For any SPI message
> that does not meet the above requirement to combine the transfers, we
> switch to original dummy cs mode but limit the clock rate to the safe
> 25MHz. This is the default auto transfer mode and it makes sure all the
> SPI message can be supported automatically under the hood.
>
> This patch also adds the driver sysfs node xfer_mode to provide
> the option for overriding the default auto mode and force it to dummy cs
> or prepend mode.
>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>
> ---
>
> Changes in v2:
> - Fix build error for Alpha platform
> Reported-by: kernel test robot <lkp@intel.com>
> - Remove use_cs_workaround option from device tree
> - Change the transfer logic to use try prepend first and if not
> prependable, switch to dummy cs mode with clock limit at the 25MHz
> - Add driver sysfs node xfer_mode for the option to override the
> transfer mode to dummy cs or prepend mode.
> - Add number of bits check in the tranfer for prepend mode eligibility
> check
> - Update commit message
>
>  drivers/spi/spi-bcm63xx-hsspi.c | 332 +++++++++++++++++++++++++++++---
>  1 file changed, 300 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
> index 8f0d31764f98..2a0bef943967 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -93,7 +93,11 @@
>
>  #define HSSPI_MAX_PREPEND_LEN                  15
>
> -#define HSSPI_MAX_SYNC_CLOCK                   30000000
> +/*
> + * Some chip require 30MHz but other require 25MHz. Use smaller value to cover
> + * both cases.
> + */
> +#define HSSPI_MAX_SYNC_CLOCK                   25000000
>
>  #define HSSPI_SPI_MAX_CS                       8
>  #define HSSPI_BUS_NUM                          1 /* 0 is legacy SPI */
> @@ -103,6 +107,16 @@
>  #define HSSPI_WAIT_MODE_INTR           1
>  #define HSSPI_WAIT_MODE_MAX                    HSSPI_WAIT_MODE_INTR
>
> +/*
> + * Default transfer mode is auto. If the msg is prependable, use the prepend
> + * mode.  If not, falls back to use the dummy cs workaround mode but limit the
> + * clock to 25MHz to make sure it works in all board design.
> + */
> +#define HSSPI_XFER_MODE_AUTO           0
> +#define HSSPI_XFER_MODE_PREPEND                1
> +#define HSSPI_XFER_MODE_DUMMYCS                2
> +#define HSSPI_XFER_MODE_MAX                    HSSPI_XFER_MODE_DUMMYCS
> +
>  struct bcm63xx_hsspi {
>         struct completion done;
>         struct mutex bus_mutex;
> @@ -116,6 +130,9 @@ struct bcm63xx_hsspi {
>         u32 speed_hz;
>         u8 cs_polarity;
>         u32 wait_mode;
> +       u32 xfer_mode;
> +       u32 prepend_cnt;
> +       u8 *prepend_buf;
>  };
>
>  static ssize_t wait_mode_show(struct device *dev, struct device_attribute *attr,
> @@ -154,8 +171,42 @@ static ssize_t wait_mode_store(struct device *dev, struct device_attribute *attr
>
>  static DEVICE_ATTR_RW(wait_mode);
>
> +static ssize_t xfer_mode_show(struct device *dev, struct device_attribute *attr,
> +                        char *buf)
> +{
> +       struct spi_controller *ctrl = dev_get_drvdata(dev);
> +       struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
> +
> +       return sprintf(buf, "%d\n", bs->xfer_mode);
> +}
> +
> +static ssize_t xfer_mode_store(struct device *dev, struct device_attribute *attr,
> +                         const char *buf, size_t count)
> +{
> +       struct spi_controller *ctrl = dev_get_drvdata(dev);
> +       struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
> +       u32 val;
> +
> +       if (kstrtou32(buf, 10, &val))
> +               return -EINVAL;
> +
> +       if (val > HSSPI_XFER_MODE_MAX) {
> +               dev_warn(dev, "invalid xfer mode %u\n", val);
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&bs->msg_mutex);
> +       bs->xfer_mode = val;
> +       mutex_unlock(&bs->msg_mutex);
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR_RW(xfer_mode);
> +
>  static struct attribute *bcm63xx_hsspi_attrs[] = {
>         &dev_attr_wait_mode.attr,
> +       &dev_attr_xfer_mode.attr,
>         NULL,
>  };
>
> @@ -163,6 +214,208 @@ static const struct attribute_group bcm63xx_hsspi_group = {
>         .attrs = bcm63xx_hsspi_attrs,
>  };
>
> +static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
> +                                 struct spi_device *spi, int hz);
> +
> +static size_t bcm63xx_hsspi_max_message_size(struct spi_device *spi)
> +{
> +       return HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN;
> +}
> +
> +static int bcm63xx_hsspi_wait_cmd(struct bcm63xx_hsspi *bs)
> +{
> +       unsigned long limit;
> +       u32 reg = 0;
> +       int rc = 0;

If the only possible return values are 0 and 1, maybe this should be a bool?

> +
> +       if (bs->wait_mode == HSSPI_WAIT_MODE_INTR) {
> +               if (wait_for_completion_timeout(&bs->done, HZ) == 0)
> +                       rc = 1;
> +       } else {
> +               /* polling mode checks for status busy bit */
> +               limit = jiffies + msecs_to_jiffies(HSSPI_POLL_STATUS_TIMEOUT_MS);
> +
> +               while (!time_after(jiffies, limit)) {
> +                       reg = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
> +                       if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
> +                               cpu_relax();
> +                       else
> +                               break;
> +               }
> +               if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
> +                       rc = 1;
> +       }
> +
> +       if (rc)
> +               dev_err(&bs->pdev->dev, "transfer timed out!\n");
> +
> +       return rc;
> +}
> +
> +static bool bcm63xx_check_msg_prependable(struct spi_master *master,
> +                                         struct spi_message *msg,
> +                                         struct spi_transfer *t_prepend)

This function does more than just checking, so I think a more
appropriate name would be something like

bcm63xx_prepare_prepend_transfer()

> +{
> +
> +       struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
> +       bool prepend = false, tx_only = false;
> +       struct spi_transfer *t;
> +
> +       /* If it is forced cs dummy workaround mode, no need to prepend message */
> +       if (bs->xfer_mode == HSSPI_XFER_MODE_DUMMYCS)
> +               return false;

That's a weird point for that, why not just move this to the caller
and check it before calling the function.

> +
> +       /*
> +        * Multiple transfers within a message may be combined into one transfer
> +        * to the controller using its prepend feature. A SPI message is prependable
> +        * only if the following are all true:
> +        *   1. One or more half duplex write transfer in single bit mode
> +        *   2. Optional full duplex read/write at the end
> +        *   3. No delay and cs_change between transfers
> +        */
> +       bs->prepend_cnt = 0;
> +       list_for_each_entry(t, &msg->transfers, transfer_list) {
> +               if ((spi_delay_to_ns(&t->delay, t) > 0) || t->cs_change) {
> +                       dev_warn(&bs->pdev->dev,
> +                                "Delay or cs change not supported in prepend mode!\n");

I don't think warn is the right level. If we are on XFER_MODE_AUTO,
this should be _dbg, since we will just fall back to the dummy cs
mode, if we are on XFER_MODE_PREPEND, this should be dev_err, since we
cannot do the message.

cs->change is technically supported when all that's requested is a
between transfer cs toggle (t->cs_change is true, t->cs_off is false
and next transfer's cs_off is also false), which automatically happens
after the transfer. Not sure if it is worth the effort implementing
that though.

> +                       break;
> +               }
> +
> +               tx_only = false;
> +               if (t->tx_buf && !t->rx_buf) {
> +                       tx_only = true;
> +                       if (bs->prepend_cnt + t->len >
> +                               (HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN)) {
> +                               dev_warn(&bs->pdev->dev,
> +                                        "exceed max buf len, abort prepending transfers!\n");
> +                               break;

why not just return false here directly? And everywhere else where you
decided that you cannot use prepend.

> +                       }
> +
> +                       if (t->tx_nbits > SPI_NBITS_SINGLE &&
> +                               !list_is_last(&t->transfer_list, &msg->transfers)) {
> +                               dev_warn(&bs->pdev->dev,
> +                                        "multi-bit prepend buf not supported!\n");
> +                               break;
> +                       }
> +
> +                       if (t->tx_nbits == SPI_NBITS_SINGLE) {
> +                               memcpy(bs->prepend_buf + bs->prepend_cnt, t->tx_buf, t->len);
> +                               bs->prepend_cnt += t->len;
> +                       }
> +               } else {
> +                       if (!list_is_last(&t->transfer_list, &msg->transfers)) {
> +                               dev_warn(&bs->pdev->dev,
> +                                        "rx/tx_rx transfer not supported when it is not last one!\n");

This is only an issue if doing multi-bit RX/TX; for single bit you can
just upgrade the whole transfer/message to duplex, you just need to
pick the read bytes then from the right offsets.

> +                               break;
> +                       }
> +               }
> +
> +               if (list_is_last(&t->transfer_list, &msg->transfers)) {
> +                       memcpy(t_prepend, t, sizeof(struct spi_transfer));
> +
> +                       if (tx_only && t->tx_nbits == SPI_NBITS_SINGLE) {
> +                               /*
> +                                * if the last one is also a single bit tx only transfer, merge
> +                                * all of them into one single tx transfer
> +                                */
> +                               t_prepend->len = bs->prepend_cnt;
> +                               t_prepend->tx_buf = bs->prepend_buf;
> +                               bs->prepend_cnt = 0;
> +                       } else {
> +                               /*
> +                                * if the last one is not a tx only transfer or dual tx xfer, all
> +                                * the previous transfers are sent through prepend bytes and
> +                                * make sure it does not exceed the max prepend len
> +                                */
> +                               if (bs->prepend_cnt > HSSPI_MAX_PREPEND_LEN) {
> +                                       dev_warn(&bs->pdev->dev,
> +                                               "exceed max prepend len, abort prepending transfers!\n");
> +                                       break;

Likewise, you can merge any amount or rx/tx/rxtx single bit transfers
together as a duplex transfer with prepend len set to 0 (so
technically not a prepend anymore ;-)

> +                               }
> +                       }
> +                       prepend = true;
> +               }
> +       }
> +
> +       return prepend;

and then if you already returned false if you cannot do prepend, you
just need to return true here and don't need the prepend variable.

> +}
> +
> +static int bcm63xx_hsspi_do_prepend_txrx(struct spi_device *spi,
> +                                        struct spi_transfer *t)
> +{
> +       struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
> +       unsigned int chip_select = spi->chip_select;
> +       u16 opcode = 0;
> +       const u8 *tx = t->tx_buf;
> +       u8 *rx = t->rx_buf;
> +       u32 reg = 0;
> +
> +       /*
> +        * shouldn't happen as we set the max_message_size in the probe.
> +        * but check it again in case some driver does not honor the max size
> +        */
> +       if (t->len + bs->prepend_cnt > (HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN)) {
> +               dev_warn(&bs->pdev->dev,
> +                        "Prepend message large than fifo size len %d prepend %d\n",
> +                        t->len, bs->prepend_cnt);
> +               return -EINVAL;
> +       }
> +
> +       bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
> +
> +       if (tx && rx)
> +               opcode = HSSPI_OP_READ_WRITE;
> +       else if (tx)
> +               opcode = HSSPI_OP_WRITE;
> +       else if (rx)
> +               opcode = HSSPI_OP_READ;
> +
> +       if ((opcode == HSSPI_OP_READ && t->rx_nbits == SPI_NBITS_DUAL) ||
> +           (opcode == HSSPI_OP_WRITE && t->tx_nbits == SPI_NBITS_DUAL)) {
> +               opcode |= HSSPI_OP_MULTIBIT;
> +
> +               if (t->rx_nbits == SPI_NBITS_DUAL) {
> +                       reg |= 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
> +                       reg |= bs->prepend_cnt << MODE_CTRL_MULTIDATA_RD_STRT_SHIFT;
> +               }
> +               if (t->tx_nbits == SPI_NBITS_DUAL) {
> +                       reg |= 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
> +                       reg |= bs->prepend_cnt << MODE_CTRL_MULTIDATA_WR_STRT_SHIFT;
> +               }
> +       }
> +
> +       reg |= bs->prepend_cnt << MODE_CTRL_PREPENDBYTE_CNT_SHIFT;
> +       __raw_writel(reg | 0xff,
> +                    bs->regs + HSSPI_PROFILE_MODE_CTRL_REG(chip_select));
> +
> +       reinit_completion(&bs->done);
> +       if (bs->prepend_cnt)
> +               memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN, bs->prepend_buf,
> +                           bs->prepend_cnt);
> +       if (tx)
> +               memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN + bs->prepend_cnt, tx,
> +                           t->len);
> +
> +       __raw_writew((u16)cpu_to_be16(opcode | t->len), bs->fifo);
> +       /* enable interrupt */
> +       if (bs->wait_mode == HSSPI_WAIT_MODE_INTR)
> +               __raw_writel(HSSPI_PINGx_CMD_DONE(0), bs->regs + HSSPI_INT_MASK_REG);
> +
> +       /* start the transfer */
> +       reg = chip_select << PINGPONG_CMD_SS_SHIFT |
> +           chip_select << PINGPONG_CMD_PROFILE_SHIFT |
> +           PINGPONG_COMMAND_START_NOW;
> +       __raw_writel(reg, bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
> +
> +       if (bcm63xx_hsspi_wait_cmd(bs))
> +               return -ETIMEDOUT;
> +
> +       if (rx)
> +               memcpy_fromio(rx, bs->fifo, t->len);
> +
> +       return 0;
> +}
> +
>  static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned int cs,
>                                  bool active)
>  {
> @@ -215,10 +468,10 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
>         int step_size = HSSPI_BUFFER_LEN;
>         const u8 *tx = t->tx_buf;
>         u8 *rx = t->rx_buf;
> -       u32 val = 0;
> -       unsigned long limit;
> +       u32 reg = 0;
>
>         bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
> +
>         bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
>
>         if (tx && rx)
> @@ -236,12 +489,12 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
>                 opcode |= HSSPI_OP_MULTIBIT;
>
>                 if (t->rx_nbits == SPI_NBITS_DUAL)
> -                       val |= 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
> +                       reg |= 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
>                 if (t->tx_nbits == SPI_NBITS_DUAL)
> -                       val |= 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
> +                       reg |= 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
>         }
>
> -       __raw_writel(val | 0xff,
> +       __raw_writel(reg | 0xff,
>                      bs->regs + HSSPI_PROFILE_MODE_CTRL_REG(chip_select));
>
>         while (pending > 0) {
> @@ -260,28 +513,13 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
>                         __raw_writel(HSSPI_PINGx_CMD_DONE(0),
>                                      bs->regs + HSSPI_INT_MASK_REG);
>
> -               /* start the transfer */
> -               __raw_writel(!chip_select << PINGPONG_CMD_SS_SHIFT |
> -                            chip_select << PINGPONG_CMD_PROFILE_SHIFT |
> -                            PINGPONG_COMMAND_START_NOW,
> -                            bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
> +               reg =  !chip_select << PINGPONG_CMD_SS_SHIFT |
> +                           chip_select << PINGPONG_CMD_PROFILE_SHIFT |
> +                           PINGPONG_COMMAND_START_NOW;
> +               __raw_writel(reg, bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
>
> -               if (bs->wait_mode == HSSPI_WAIT_MODE_INTR) {
> -                       if (wait_for_completion_timeout(&bs->done, HZ) == 0)
> -                               goto err_timeout;
> -               } else {
> -                       /* polling mode checks for status busy bit */
> -                       limit = jiffies + msecs_to_jiffies(HSSPI_POLL_STATUS_TIMEOUT_MS);
> -                       while (!time_after(jiffies, limit)) {
> -                               val = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
> -                               if (val & HSSPI_PINGPONG_STATUS_SRC_BUSY)
> -                                       cpu_relax();
> -                               else
> -                                       break;
> -                       }
> -                       if (val & HSSPI_PINGPONG_STATUS_SRC_BUSY)
> -                               goto err_timeout;
> -               }
> +               if (bcm63xx_hsspi_wait_cmd(bs))
> +                       return -ETIMEDOUT;
>
>                 if (rx) {
>                         memcpy_fromio(rx, bs->fifo, curr_step);
> @@ -292,10 +530,6 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
>         }
>
>         return 0;
> -
> -err_timeout:
> -       dev_err(&bs->pdev->dev, "transfer timed out!\n");
> -       return -ETIMEDOUT;
>  }
>
>  static int bcm63xx_hsspi_setup(struct spi_device *spi)
> @@ -344,9 +578,23 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
>         int status = -EINVAL;
>         int dummy_cs;
>         bool restore_polarity = true;
> +       struct spi_transfer t_prepend;
>
>         mutex_lock(&bs->msg_mutex);
> -       /* This controller does not support keeping CS active during idle.
> +       if (bcm63xx_check_msg_prependable(master, msg, &t_prepend)) {
> +               status = bcm63xx_hsspi_do_prepend_txrx(spi, &t_prepend);
> +               msg->actual_length += (t_prepend.len + bs->prepend_cnt);

why +=? shouldn't this be the only place in this case where this is set?

> +               goto msg_done;
> +       }
> +
> +       if (bs->xfer_mode == HSSPI_XFER_MODE_PREPEND) {
> +               dev_warn(&bs->pdev->dev,
> +                       "User set prepend mode but msg not prependable! Fail the xfer!\n");

If we are failing, this should be a dev_err, not a dev_warn

> +               goto msg_done;
> +       }

I think from a readability standpoint it would be better to move the
cs_workaround parts into their own function, and have this as

    bool prependable = false;

    if (bs->xfer_mode != HSSPI_XFER_MODE_DUMMYCS)
        prependable = bcm63xx_prepare_prepend_transfer(...);

    if (prependable) {
      status = bcm63xx_hsspi_do_prepend_txrx(...);
      msg->actual_legth += ...;
    } else {
      if (bs->xfer_mode == HSSPI_XFER_MODE_PREPEND) {
           /* we may not use dummy cs */
           dev_err(...);
           status = -EINVAL;
      } else {
           status = bcm63xx_hsspi_do_dummy_cs_txrx(...);
      }
    }

with (bcm63xx_hsspi_do_dummy_cs_txrx being the proposed function name).

> +
> +       /*
> +        * This controller does not support keeping CS active during idle.
>          * To work around this, we use the following ugly hack:
>          *
>          * a. Invert the target chip select's polarity so it will be active.
> @@ -364,6 +612,17 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
>         bcm63xx_hsspi_set_cs(bs, dummy_cs, true);
>
>         list_for_each_entry(t, &msg->transfers, transfer_list) {
> +               /*
> +                * We are here because one of reasons below:
> +                * a. Message is not prependable and in default auto xfer mode. This mean
> +                *    we fallback to dummy cs mode at maximum 25MHz safe clock rate.
> +                * b. User set to use the dummy cs mode.
> +                */
> +               if (bs->xfer_mode == HSSPI_XFER_MODE_AUTO) {
> +                       if (t->speed_hz > HSSPI_MAX_SYNC_CLOCK)
> +                               t->speed_hz = HSSPI_MAX_SYNC_CLOCK;

OTOH, this may be a point where a dev_warn (once?) might be a good
idea, since the device may depend on a certain speed to avoid buffer
overruns (e.g. audio streams - not sure if that exists), so a warning
that the transfer speed was reduced will help identifying the source.



> +               }
> +
>                 status = bcm63xx_hsspi_do_txrx(spi, t);
>                 if (status)
>                         break;
> @@ -396,6 +655,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
>         if (restore_polarity)
>                 bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
>
> +msg_done:
>         mutex_unlock(&bs->msg_mutex);
>         msg->status = status;
>         spi_finalize_current_message(master);
> @@ -490,6 +750,11 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>         bs->speed_hz = rate;
>         bs->fifo = (u8 __iomem *)(bs->regs + HSSPI_FIFO_REG(0));
>         bs->wait_mode = HSSPI_WAIT_MODE_POLLING;
> +       bs->prepend_buf = devm_kzalloc(dev, HSSPI_BUFFER_LEN, GFP_KERNEL);
> +       if (!bs->prepend_buf) {
> +               ret = -ENOMEM;
> +               goto out_put_master;
> +       }
>
>         mutex_init(&bs->bus_mutex);
>         mutex_init(&bs->msg_mutex);
> @@ -508,6 +773,9 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>         master->num_chipselect = num_cs;
>         master->setup = bcm63xx_hsspi_setup;
>         master->transfer_one_message = bcm63xx_hsspi_transfer_one;
> +       master->max_transfer_size = bcm63xx_hsspi_max_message_size;
> +       master->max_message_size = bcm63xx_hsspi_max_message_size;
> +
>         master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
>                             SPI_RX_DUAL | SPI_TX_DUAL;
>         master->bits_per_word_mask = SPI_BPW_MASK(8);
> --
> 2.37.3
>
