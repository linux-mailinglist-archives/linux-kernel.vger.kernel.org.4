Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3843371F441
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjFAU4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFAU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:56:40 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EF99;
        Thu,  1 Jun 2023 13:56:36 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 83BC35FD10;
        Thu,  1 Jun 2023 23:56:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685652993;
        bh=coMHb5C72d+RplaEoZqklUJnMs+FQ+6e5vGvPA2/Dhc=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=BV97heccxF3nWs/1dA6qy4DVvG/SlSXCgaq50ILopAE6BrLt+xD7rtcOFRlDhH3w4
         UX5mJvaAhxqn3vMI5NbV4mOyNRWtjhQnB+vdQzou1rvZDJGlJ/kxM6rL5KZR4MkabC
         DK2WO6MtG4EUEAeeRDvlYvvnac0Yb/5nUpSnp53t02MkW0A6ly/xPNt4NDQsGbRmbX
         NOhLsrdvpx8ZXYFvUhsrms8JkbhjO0jL3pcEN36oJtdzzC+cSBjE+AOdYulcREgOyB
         4crXwhb1H6cpC/rGnJddzn1m6CKp8V1DzQFLPBU2NjrYB9nsYyTrm+tqGQThvuwRAF
         UFzZaa5BfKX+Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Jun 2023 23:56:30 +0300 (MSK)
Message-ID: <dcb05f27-4c6d-0544-ff0d-288a6848ccaf@sberdevices.ru>
Date:   Thu, 1 Jun 2023 23:52:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>, Vyacheslav <adeep@lexina.in>
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
 <a52335ea-6545-8ca6-d318-38b7ffc64368@lexina.in>
 <CAFBinCDmkGnD5o_rV6K73De2XmHDxRYveDwNAy3iA+Kwr5sdqg@mail.gmail.com>
 <6910550a-b025-0d97-0b39-bc89b235541e@sberdevices.ru>
 <CAFBinCCk6OziOxt2AY1A25C=9_pibhHsDK0wJNZ_AyHMd=z6SQ@mail.gmail.com>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <CAFBinCCk6OziOxt2AY1A25C=9_pibhHsDK0wJNZ_AyHMd=z6SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/01 16:24:00 #21397712
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 23:41, Martin Blumenstingl wrote:
> Hi George,
>
> On Mon, May 22, 2023 at 5:47 PM Старк Георгий Николаевич
> <GNStark@sberdevices.ru> wrote:
>> Hello Martin
>>
>> Actually you were right that my patch affects only meson8 family not the all new ones, my bad.
>> It's clear from the driver code meson_saradc.c and dts files.
>> I've made an experiment on a113l soc - changingclock_rate inmeson_sar_adc_param and measuring adc channel many times
>> and with low clockfrequency (priv->adc_clk) time of measurementis high
>> and vice versa. ADC_CLK_DIV field in SAR_ADC_REG3 is always zero.
> Thanks for sharing your findings!
>
>> I need to get s805 (meson8) board for example and made experiment on it.
> If you don't find any Meson8 (S802)/Meson8b (S805) or Meson8m2 (S812)
> board then please provide the code that you used for your experiment
> as a patch so I can give it a try on my Odroid-C1 (Meson8b).
>
>
> Best regards,
> Martin
>
Hello Martin

Here the test I promised:
Question: what's the real size of clock divder field in SAR_ADC_REG3 register in saradc in meson8 socs?
The current kernel code says 5 bits
The datasheet says 6 bit

The parent clock of adc clock is 24Mhz
I can check it here by:

# cat /sys/kernel/debug/clk/clk_summary
  xtal                                 4        4        1    24000000          0     0  50000         Y
     c1108680.adc#adc_div              1        1        0      1142858         0     0  50000         Y
        c1108680.adc#adc_en            1        1        0      1142858         0     0  50000         Y

for divider width 5bit min adc clock is 24Mhz / 32 =  750KHZ
for divider width 6bit min adc clock is 24Mhz / 64 =  375KHz

I suppose that the lower adc clock rate the higher measurement time
so I need to get measurement time at both clk freqs and the times differ so
6bit divider is really applied

I performed test at Odroid-C1, kernel 6.2-rc8
Two kernel patches must be applied:

the topic starter patch and the helper patch at the end of the letter
In the helper patch I turn on CLOCK_ALLOW_WRITE_DEBUGFS to change clock rate from she shell
and use ktime_get_raw_ts64 to measure measurement time

So the the test itself:
cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in_voltage3_raw
[ 1781.226309] ==== freq: 1142858 time 42408000

# echo 750000 > /sys/kernel/debug/clk/c1108680.adc#adc_en/clk_rate
# cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in_voltage3_raw
[ 1790.728656] ==== freq: 750000 time 49173000

# echo 375000 > /sys/kernel/debug/clk/c1108680.adc#adc_en/clk_rate
# cat /sys/devices/platform/soc/c1100000.cbus/c1108680.adc/iio:device0/in_voltage3_raw
[ 1816.955477] ==== freq: 375000 time 68245000

# cat /sys/kernel/debug/clk/clk_summary
  xtal                                 4        4        1    24000000          0     0  50000         Y
     c1108680.adc#adc_div              1        1        0      375000          0     0  50000         Y
        c1108680.adc#adc_en            1        1        0      375000          0     0  50000         Y

Helper patch:

diff --git a/drivers/clk/baikal-t1/ccu-pll.c 
b/drivers/clk/baikal-t1/ccu-pll.c
index 13ef28001439..226e0d46a994 100644
--- a/drivers/clk/baikal-t1/ccu-pll.c
+++ b/drivers/clk/baikal-t1/ccu-pll.c
@@ -363,7 +363,7 @@ static const struct ccu_pll_dbgfs_fld ccu_pll_flds[] = {
   * therefore we don't provide any kernel config based compile time 
option for
   * this feature to enable.
   */
-#undef CCU_PLL_ALLOW_WRITE_DEBUGFS
+#define CCU_PLL_ALLOW_WRITE_DEBUGFS
  #ifdef CCU_PLL_ALLOW_WRITE_DEBUGFS

  static int ccu_pll_dbgfs_bit_set(void *priv, u64 val)
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e62552a75f08..d552acdaa7bc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3263,7 +3263,7 @@ static int clk_dump_show(struct seq_file *s, void 
*data)
  }
  DEFINE_SHOW_ATTRIBUTE(clk_dump);

-#undef CLOCK_ALLOW_WRITE_DEBUGFS
+#define CLOCK_ALLOW_WRITE_DEBUGFS
  #ifdef CLOCK_ALLOW_WRITE_DEBUGFS
  /*
   * This can be dangerous, therefore don't provide any real compile time
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 6959a0064551..65132d3ca46a 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -24,6 +24,8 @@
  #include <linux/regulator/consumer.h>
  #include <linux/mfd/syscon.h>

+#include <linux/timekeeping.h>
+
  #define MESON_SAR_ADC_REG0                                     0x00
         #define MESON_SAR_ADC_REG0_PANEL_DETECT BIT(31)
         #define MESON_SAR_ADC_REG0_BUSY_MASK GENMASK(30, 28)
@@ -599,6 +601,8 @@ static int meson_sar_adc_get_sample(struct iio_dev 
*indio_dev,
         struct device *dev = indio_dev->dev.parent;
         int ret;

+       int i;
+
         if (chan->type == IIO_TEMP && !priv->temperature_sensor_calibrated)
                 return -ENOTSUPP;

@@ -606,16 +610,28 @@ static int meson_sar_adc_get_sample(struct iio_dev 
*indio_dev,
         if (ret)
                 return ret;

-       /* clear the FIFO to make sure we're not reading old values */
-       meson_sar_adc_clear_fifo(indio_dev);

-       meson_sar_adc_set_averaging(indio_dev, chan, avg_mode, avg_samples);
+       struct timespec64 ts0, ts1;
+       ktime_get_raw_ts64(&ts0);

-       meson_sar_adc_enable_channel(indio_dev, chan);
+       for (i = 0; i < 1000; i++) {

-       meson_sar_adc_start_sample_engine(indio_dev);
-       ret = meson_sar_adc_read_raw_sample(indio_dev, chan, val);
-       meson_sar_adc_stop_sample_engine(indio_dev);
+               /* clear the FIFO to make sure we're not reading old 
values */
+               meson_sar_adc_clear_fifo(indio_dev);
+
+               meson_sar_adc_set_averaging(indio_dev, chan, avg_mode, 
avg_samples);
+
+               meson_sar_adc_enable_channel(indio_dev, chan);
+
+               meson_sar_adc_start_sample_engine(indio_dev);
+               ret = meson_sar_adc_read_raw_sample(indio_dev, chan, val);
+               meson_sar_adc_stop_sample_engine(indio_dev);
+       }
+
+       ktime_get_raw_ts64(&ts1);
+       u64 t0 = NSEC_PER_SEC * ts0.tv_sec + ts0.tv_nsec;
+       u64 t1 = NSEC_PER_SEC * ts1.tv_sec + ts1.tv_nsec;
+       printk("==== freq: %lu time %lld\n", 
clk_get_rate(priv->adc_clk), t1 - t0);

         meson_sar_adc_unlock(indio_dev);

Best regards
George

