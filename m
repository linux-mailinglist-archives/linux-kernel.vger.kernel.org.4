Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAA15FC2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJLJKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJLJKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:10:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E83343B;
        Wed, 12 Oct 2022 02:10:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0519B6601704;
        Wed, 12 Oct 2022 10:10:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665565803;
        bh=QUqQMPPFvgEfJrocAzZzhDQ+j/eNqklToiqdvzIIEEQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JgO98MGuvsNRNwEPVTmjJJ68GStUNy6gZtnPu6gvWu/fCuAXu6sCUFl4O+sUWz4bJ
         CZw/tkEO+liUlJnYnovpXEbsHKv8kjPfKaCBWnfFU9kFlM73//al/EVJOJk6ExcEmI
         Zm64tTmAqo29o+1JmnO6Wzag63JaztDffWJHKkwT2BKZEqty2CejO2ldu60qapgB/k
         uhzx2KXqfQQVJ7zyS9n5DVuirBihBlzW6ZniUCegKBQC95hSL9GgHW3qBcp19wRLSP
         dQCsqCBfEiUGevg0mL5Fsl4NMC1WnAtQgi5pUoHnryp8dqoxQqcZL7vXAXxolJqAn0
         490jgHArm0uQA==
Message-ID: <c4a1eb9f-016d-c184-e494-c869038b87ff@collabora.com>
Date:   Wed, 12 Oct 2022 11:09:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] clk: mediatek: clk-mux: Add .determine_rate() callback
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221011135548.318323-1-angelogioacchino.delregno@collabora.com>
 <20221012085555.3nls7ja56vlnaz2w@houat>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221012085555.3nls7ja56vlnaz2w@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/10/22 10:55, Maxime Ripard ha scritto:
> Hi,
> 
> On Tue, Oct 11, 2022 at 03:55:48PM +0200, AngeloGioacchino Del Regno wrote:
>> Since commit 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests
>> to the parent"), the clk_rate_request is .. as the title says, not
>> forwarded anymore to the parent:
> 
> It's not entirely true, the rate request should still be forwarded, but
> we don't pass the same instance of clk_rate_request anymore.
> 
>> this produces an issue with the MediaTek clock MUX driver during GPU
>> DVFS on MT8195, but not on MT8192 or others.
>>
>> This is because, differently from others, like MT8192 where all of
>> the clocks in the MFG parents tree are of mtk_mux type, but in the
>> parent tree of MT8195's MFG clock, we have one mtk_mux clock and
>> one (clk framework generic) mux clock, like so:
>>
>> names: mfg_bg3d -> mfg_ck_fast_ref -> top_mfg_core_tmp (or) mfgpll
>> types: mtk_gate ->      mux        ->     mtk_mux      (or) mtk_pll
>>
>> To solve this issue and also keep the GPU DVFS clocks code working
>> as expected, wire up a .determine_rate() callback for the mtk_mux
>> ops; for that, the standard clk_mux_determine_rate_flags() was used
>> as it was possible to.
> 
> It probably fixes things indeed, but I'm a bit worried that it just
> works around the actual issue instead of fixing the actual bug...
> 
>> This commit was successfully tested on MT6795 Xperia M5, MT8173 Elm,
>> MT8192 Spherion and MT8195 Tomato; no regressions were seen.
>>
>> For the sake of some more documentation about this issue here's the
>> trace of it:
>>
>> [   12.211587] ------------[ cut here ]------------
>> [   12.211589] WARNING: CPU: 6 PID: 78 at drivers/clk/clk.c:1462 clk_core_init_rate_req+0x84/0x90
>> [   12.211593] Modules linked in: stp crct10dif_ce mtk_adsp_common llc rfkill snd_sof_xtensa_dsp
>>                 panfrost(+) sbs_battery cros_ec_lid_angle cros_ec_sensors snd_sof_of
>>                 cros_ec_sensors_core hid_multitouch cros_usbpd_logger snd_sof gpu_sched
>>                 snd_sof_utils fuse ipv6
>> [   12.211614] CPU: 6 PID: 78 Comm: kworker/u16:2 Tainted: G        W          6.0.0-next-20221011+ #58
>> [   12.211616] Hardware name: Acer Tomato (rev2) board (DT)
>> [   12.211617] Workqueue: devfreq_wq devfreq_monitor
>> [   12.211620] pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   12.211622] pc : clk_core_init_rate_req+0x84/0x90
>> [   12.211625] lr : clk_core_forward_rate_req+0xa4/0xe4
>> [   12.211627] sp : ffff80000893b8e0
>> [   12.211628] x29: ffff80000893b8e0 x28: ffffdddf92f9b000 x27: ffff46a2c0e8bc05
>> [   12.211632] x26: ffff46a2c1041200 x25: 0000000000000000 x24: 00000000173eed80
>> [   12.211636] x23: ffff80000893b9c0 x22: ffff80000893b940 x21: 0000000000000000
>> [   12.211641] x20: ffff46a2c1039f00 x19: ffff46a2c1039f00 x18: 0000000000000000
>> [   12.211645] x17: 0000000000000038 x16: 000000000000d904 x15: 0000000000000003
>> [   12.211649] x14: ffffdddf9357ce48 x13: ffffdddf935e71c8 x12: 000000000004803c
>> [   12.211653] x11: 00000000a867d7ad x10: 00000000a867d7ad x9 : ffffdddf90c28df4
>> [   12.211657] x8 : ffffdddf9357a980 x7 : 0000000000000000 x6 : 0000000000000004
>> [   12.211661] x5 : ffffffffffffffc8 x4 : 00000000173eed80 x3 : ffff80000893b940
>> [   12.211665] x2 : 00000000173eed80 x1 : ffff80000893b940 x0 : 0000000000000000
>> [   12.211669] Call trace:
>> [   12.211670]  clk_core_init_rate_req+0x84/0x90
>> [   12.211673]  clk_core_round_rate_nolock+0xe8/0x10c
>> [   12.211675]  clk_mux_determine_rate_flags+0x174/0x1f0
>> [   12.211677]  clk_mux_determine_rate+0x1c/0x30
>> [   12.211680]  clk_core_determine_round_nolock+0x74/0x130
>> [   12.211682]  clk_core_round_rate_nolock+0x58/0x10c
>> [   12.211684]  clk_core_round_rate_nolock+0xf4/0x10c
>> [   12.211686]  clk_core_set_rate_nolock+0x194/0x2ac
>> [   12.211688]  clk_set_rate+0x40/0x94
>> [   12.211691]  _opp_config_clk_single+0x38/0xa0
>> [   12.211693]  _set_opp+0x1b0/0x500
>> [   12.211695]  dev_pm_opp_set_rate+0x120/0x290
>> [   12.211697]  panfrost_devfreq_target+0x3c/0x50 [panfrost]
>> [   12.211705]  devfreq_set_target+0x8c/0x2d0
>> [   12.211707]  devfreq_update_target+0xcc/0xf4
>> [   12.211708]  devfreq_monitor+0x40/0x1d0
>> [   12.211710]  process_one_work+0x294/0x664
>> [   12.211712]  worker_thread+0x7c/0x45c
>> [   12.211713]  kthread+0x104/0x110
>> [   12.211716]  ret_from_fork+0x10/0x20
>> [   12.211718] irq event stamp: 7102
>> [   12.211719] hardirqs last  enabled at (7101): [<ffffdddf904ea5a0>] finish_task_switch.isra.0+0xec/0x2f0
>> [   12.211723] hardirqs last disabled at (7102): [<ffffdddf91794b74>] el1_dbg+0x24/0x90
>> [   12.211726] softirqs last  enabled at (6716): [<ffffdddf90410be4>] __do_softirq+0x414/0x588
>> [   12.211728] softirqs last disabled at (6507): [<ffffdddf904171d8>] ____do_softirq+0x18/0x24
>> [   12.211730] ---[ end trace 0000000000000000 ]---
> 
> ... Indeed, you shouldn't hit that warning at all. It happens in
> clk_core_round_rate_nolock, which takes (before your patch) the
> CLK_SET_RATE_PARENT branch. This indeed has been changed by the patch
> you mentioned, and will call clk_core_forward_rate_req() now, that in
> turn calls clk_core_init_rate_nolock().
> 
> I think the warning you hit is because core->parent is NULL, which is
> passed to clk_core_forward_rate_req() as the parent argument, and we'll
> call clk_core_init_rate_req() with parent set as the core argument.
> 
> In clk_core_init_rate_req(), the first thing we do is a WARN_ON(!core),
> which is what you hit here I think.
> 
> This is different to the previous behavior that was calling
> clk_core_round_rate_nolock() with core->parent directly, and
> clk_core_round_rate_nolock() if its core argument is NULL will set
> req->rate to 0 and bail out without returning an error.
> 
> Now, your patch probably works because now that you provide a
> determine_rate implementation, clk_core_can_round() returns true and
> you'll take a different branch in clk_core_round_rate_nolock(), avoiding
> that issue entirely.
> 
> Does that patch work better (on top of next-20221012)?

Hello Maxime,

I admit I didn't go too deep in the research, as my brain processed that as
"this is a mux clock, not really different from a standard mux, this callback
is missing, that's not optimal"... then that fixed it and called it a day.

I should've prolonged my research for a better understanding of what was
actually going on.
What you said actually opened my mind and, with little surprise, your patch
works as good as mine - no warnings and the clock scales as expected!

I still think that the mtk-mux driver should get a determine_rate callback but,
at this point, that's going to have an entirely different commit description...

Please go on and send your patch: if you want, please remember to add me to
the Cc's, so that I can give you my R-b tag in a timely manner.

Cheers!
Angelo

> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c3c3f8c07258..b831a4227236 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1459,12 +1459,15 @@ static void clk_core_init_rate_req(struct clk_core * const core,
>   {
>   	struct clk_core *parent;
> 
> -	if (WARN_ON(!core || !req))
> +	if (WARN_ON(!req))
>   		return;
> 
>   	memset(req, 0, sizeof(*req));
> -
>   	req->rate = rate;
> +
> +	if (!core)
> +		return;
> +
>   	clk_core_get_boundaries(core, &req->min_rate, &req->max_rate);
> 
>   	parent = core->parent;
> 
> Thanks!
> Maxime

