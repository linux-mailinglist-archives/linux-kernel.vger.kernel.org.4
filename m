Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881E73D734
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjFZFfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZFfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:35:12 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA91CE1;
        Sun, 25 Jun 2023 22:35:05 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CBF318139;
        Mon, 26 Jun 2023 13:34:56 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 13:34:56 +0800
Received: from [192.168.1.115] (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 13:34:56 +0800
Message-ID: <32d1db3e-be6a-5219-b886-14c5f5102a5f@starfivetech.com>
Date:   Mon, 26 Jun 2023 13:34:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 9/9] drm/verisilicon: Add starfive hdmi driver
Content-Language: en-US
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
 <CGME20230602081437epcas1p36b7961b1d3f01dbed3fe2672a92e9d92@epcas1p3.samsung.com>
 <20230602074043.33872-10-keith.zhao@starfivetech.com>
 <003a01d9a57b$c140f340$43c2d9c0$@samsung.com>
From:   Keith Zhao <keith.zhao@starfivetech.com>
To:     undisclosed-recipients:;
In-Reply-To: <003a01d9a57b$c140f340$43c2d9c0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yes I tested 
modetest -M starfive -D 0 -s 116@31:1280x720-59.94 -v
modetest -M starfive -D 0 -s 116@31:1920x1080 -v

and the second command will repeat the problem
as you advise at the beginning
I call the "starfive_hdmi_setup"  function in the "starfive_hdmi_encoder_enable"
instead of "starfive_hdmi_encoder_mode_set"
resolve the problem
i will add this modify in my next patch

Thank you Hoegeun

On 2023/6/23 10:38, Hoegeun Kwon wrote:
> Hi Keith,
> 
> There is a problem with stopping when changing modes.
> 
> Below test log
> 
> root:~> modetest -Mstarfive -c
> Connectors:
> id      encoder status          name            size (mm)       modes
> encoders
> 116     115     connected       HDMI-A-1        320x180         51      115
>   modes:
>         index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
>   #0 1280x800 59.91 1280 1328 1360 1440 800 803 809 823 71000 flags: phsync,
> pvsync; type: preferred, driver
>   #1 1920x1080 60.00 1920 2008 2052 2200 1080 1084 1089 1125 148500 flags:
> phsync, pvsync; type: driver
> [...]
> 
> root:~> modetest -Mstarfive -s 116:#0 -v
> setting mode 1280x800-59.91Hz on connectors 116, crtc 31
> freq: 60.65Hz
> freq: 59.91Hz
> freq: 59.91Hz
> 
> root:~> modetest -Mstarfive -s 116:#1 -v
> setting mode 1920x1080-60.00Hz on connectors 116, crtc 31
> [   94.535626] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [   94.560985] rcu:     1-...0: (20 ticks this GP)
> idle=c9bc/1/0x4000000000000000 softirq=3869/3871 fqs=1120
> [   94.589532] rcu:     (detected by 3, t=5264 jiffies, g=4645, q=63
> ncpus=4)
> [   94.615335] Task dump for CPU 1:
> [   94.637723] task:modetest        state:R  running task     stack:0
> pid:407   ppid:397    flags:0x00000008
> [   94.667299] Call Trace:
> [   94.689297] [<ffffffff80d1e8fc>] __schedule+0x2a8/0xa52
> [   94.714221] [<ffffffff80d1f100>] schedule+0x5a/0xdc
> [   94.738626] [<ffffffff80d25a14>] schedule_timeout+0x220/0x2a6
> [   94.763762] [<ffffffff80d2037a>] wait_for_completion+0xfe/0x126
> [   94.789073] [<ffffffff8002ffe4>] kthread_flush_worker+0x82/0xa0
> 
> 
>> -----Original Message-----
>> From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
>> Keith Zhao
>> Sent: Friday, June 2, 2023 4:41 PM
>> To: dri-devel@lists.freedesktop.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-riscv@lists.infradead.org; linux-
>> media@vger.kernel.org; linaro-mm-sig@lists.linaro.org
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Sumit Semwal
>> <sumit.semwal@linaro.org>; Emil Renner Berthing <kernel@esmil.dk>;
>> Shengyang Chen <shengyang.chen@starfivetech.com>; Conor Dooley
>> <conor+dt@kernel.org>; Albert Ou <aou@eecs.berkeley.edu>; Thomas
>> Zimmermann <tzimmermann@suse.de>; Jagan Teki <jagan@edgeble.ai>; Rob
>> Herring <robh+dt@kernel.org>; Chris Morgan <macromorgan@hotmail.com>; Paul
>> Walmsley <paul.walmsley@sifive.com>; Keith Zhao
>> <keith.zhao@starfivetech.com>; Bjorn Andersson <andersson@kernel.org>;
>> Changhuang Liang <changhuang.liang@starfivetech.com>; Jack Zhu
>> <jack.zhu@starfivetech.com>; Palmer Dabbelt <palmer@dabbelt.com>; Shawn
>> Guo <shawnguo@kernel.org>; christian.koenig@amd.com
>> Subject: [PATCH 9/9] drm/verisilicon: Add starfive hdmi driver
>> 
>> Add HDMI dirver for StarFive SoC JH7110.
>> 
>> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
>> ---
>>  drivers/gpu/drm/verisilicon/Kconfig         |  11 +
>>  drivers/gpu/drm/verisilicon/Makefile        |   1 +
>>  drivers/gpu/drm/verisilicon/starfive_hdmi.c | 928 ++++++++++++++++++++
>> drivers/gpu/drm/verisilicon/starfive_hdmi.h | 296 +++++++
>>  drivers/gpu/drm/verisilicon/vs_drv.c        |   6 +
>>  drivers/gpu/drm/verisilicon/vs_drv.h        |   4 +
>>  6 files changed, 1246 insertions(+)
>>  create mode 100644 drivers/gpu/drm/verisilicon/starfive_hdmi.c
>>  create mode 100644 drivers/gpu/drm/verisilicon/starfive_hdmi.h
> 
> [...]
> 
>> diff --git a/drivers/gpu/drm/verisilicon/starfive_hdmi.c
>> b/drivers/gpu/drm/verisilicon/starfive_hdmi.c
>> new file mode 100644
>> index 000000000000..128ecca03309
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/starfive_hdmi.c
>> @@ -0,0 +1,928 @@
> 
> [...]
> 
>> +static int starfive_hdmi_setup(struct starfive_hdmi *hdmi,
>> +			       struct drm_display_mode *mode) {
> 
> [...]
> 
>> +	return 0;
>> +}
>> +
>> +static void starfive_hdmi_encoder_mode_set(struct drm_encoder *encoder,
>> +					   struct drm_display_mode *mode,
>> +					   struct drm_display_mode
> *adj_mode) {
>> +	struct starfive_hdmi *hdmi = encoder_to_hdmi(encoder);
>> +
>> +	starfive_hdmi_setup(hdmi, adj_mode);
> 
> When starfive_hdmi_setup runs here,
> when changing the mode, a problem occurs because try to write a value to reg
> in a state that is not resumed after suspend.
> 
>> +
>> +	memcpy(&hdmi->previous_mode, adj_mode, sizeof(hdmi-
>> >previous_mode)); }
>> +
>> +static void starfive_hdmi_encoder_enable(struct drm_encoder *encoder) {
>> +	struct starfive_hdmi *hdmi = encoder_to_hdmi(encoder);
>> +
>> +	pm_runtime_get_sync(hdmi->dev);
> 
> So if move the call point of starfive_hdmi_setup here, it works normally.
> 
>> +}
> 
> Best regards,
> Hoegeun
> 
> 
