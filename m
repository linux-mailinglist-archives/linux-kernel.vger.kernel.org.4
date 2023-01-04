Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF565D356
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 13:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbjADM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 07:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbjADMz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 07:55:57 -0500
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 04:55:20 PST
Received: from smtp-6.sys.kth.se (smtp-6.sys.kth.se [130.237.48.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89104395C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 04:55:20 -0800 (PST)
Received: from [192.168.1.20] (h-155-4-24-139.A980.priv.bahnhof.se [155.4.24.139])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: arvidb)
        by smtp-6.sys.kth.se (Postfix) with ESMTPSA id 4Nn8TL2nnHzPNQG;
        Wed,  4 Jan 2023 13:45:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-6.sys.kth.se 4Nn8TL2nnHzPNQG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kth.se; s=default;
        t=1672836327; bh=bg5GHNkmweiqnaXU/mkscwR9L6RhsX+wTiTR5VXOTq4=;
        h=Date:From:Subject:To:Cc:From;
        b=QSaRQ/1X5tY6MgZfNmH0OrB6Byo/g5HjjGe4tjow82aI9SsJQ9asCfnFIjDiczVp6
         B4rcegWMKQmZrTxuR5sTfA4cMnPa+uncqyIV7hOJHnihM4Gu+E7pwB9+iVqJQQ7IZY
         //1oMexkZgPos1K73/m2FZmOaZVqCgcMyC+POJ1U=
Message-ID: <3c789d57-7f2d-22fd-18ca-980be5c05393@kth.se>
Date:   Wed, 4 Jan 2023 13:45:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
From:   Arvid Brodin <arvidb@kth.se>
Subject: McASP dual serializers and codecs - cannot figure out device tree
 mappings
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to create a four-channel "audio-graph-card" consisting of two
TI PCM512X codecs, each connected to its own serializer on one of the McASP
peripherals on a Beaglebone Black. (For context, we can call the channels
"MainL", "MainR", "Sub1", and "Sub2".)

What is the device tree syntax for this? After reading the bindings
documentation (e.g. "Multi DAI with DPCM" example) and searching for working
examples (which I have not been able to find any, only people asking how to
do this) it is still unclear to me how to map cpu endpoints to mcasp
serializers and slots.

So far I have two channel sound from either codec working fine, but I cannot
seem to get both working simultaneously; I'm obviously missing something.
(I've also tried using only one serializer and 4 TDM slots, adding different
combinations of convert-channels, as well as using a "simple-audio-card"
instead, among many other unsuccessful things.)

Kernel is linux-5.10.145-ti-r55; source at
https://github.com/beagleboard/linux/tree/5.10.145-ti-r55.

Below dts works for either codec individually after (un)commenting the
relevant sections:

--- code ---

&mcasp0 {
	#sound-dai-cells = <0>;
	pinctrl-names = "default";
	pinctrl-0 = <&mcasp0_pins>;
	status = "okay";
	op-mode = <0>;  /* MCASP_IIS_MODE */
	tdm-slots = <2>;
	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
			0 0 1 0  // Pi DAC+
//			1 0 0 0  // Pi DAC Pro
//			1 0 1 0  // Both
		>;
	tx-num-evt = <32>;
	rx-num-evt = <32>;

	mcasp0_port: port@0 {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu_dai0: endpoint@0 {
			reg = <0>;
			dai-format = "i2s";
			frame-master = <&mcasp0_port>;
			bitclock-master = <&mcasp0_port>;
			remote-endpoint = <&codec_dai0>;
			clocks = <&clk_mcasp0>;
		};
/*
		cpu_dai1: endpoint@1 {
			reg = <1>;
			dai-format = "i2s";
			frame-master = <&mcasp0_port>;
			bitclock-master = <&mcasp0_port>;
			remote-endpoint = <&codec_dai1>;
			clocks = <&clk_mcasp0>;
		};
*/
	};
};


&{/} {
	sound {
		compatible = "audio-graph-card";
		label = "AmazingDAC";     // Indulge me ;)
		dais = <&mcasp0_port>;
	};
};

&i2c2 {
	#address-cells = <1>;
	#size-cells = <0>;
	audio_codec1: pcm5122@4c {
		#sound-dai-cells = <0>;
		compatible = "ti,pcm5122";
		reg = <0x4c>;

		// AVDD created on-board Pi-DAC+ from RPi pin 2 = 5 V.
		AVDD-supply = <&avdd_3v3>;
		// DVDD fed directly from RPi pin 1 = 3.3 V.
		DVDD-supply = <&vdd_3v3exp>;
		// CPVDD fed directly from RPi pin 1 = 3.3 V.
		CPVDD-supply = <&vdd_3v3exp>;

		port {
			codec_dai0: endpoint {
				remote-endpoint = <&cpu_dai0>;
			};
		};
	};
	pcm5142@4e {
		#sound-dai-cells = <0>;
		compatible = "ti,pcm5142";
		reg = <0x4e>;

		// AVDD created on-board Pi-DAC+ from RPi pin 2 = 5 V.
		AVDD-supply = <&avdd_3v3>;
		// DVDD fed directly from RPi pin 1 = 3.3 V.
		DVDD-supply = <&vdd_3v3exp>;
		// CPVDD fed directly from RPi pin 1 = 3.3 V.
		CPVDD-supply = <&vdd_3v3exp>;
/*
		port {
			codec_dai1: endpoint {
				remote-endpoint = <&cpu_dai1>;
			};
		};
*/
	};
};

--- /code ---

... but if I enable both, and boot with

setenv dtb_overlay "/lib/firmware/BB-GRAPH-AUDIO-PCM5XXX-00A0.dtbo"
setenv optargs 'snd_soc_davinci_mcasp.dyndbg=+plf snd_soc_audio_graph_card.dyndbg=+plf snd_soc_pcm512x.dyndbg=+plf snd_soc_core.dyndbg=+plf'
run bootcmd

I get this output from the kernel:

kernel: snd_soc_register_dai:2308: snd-soc-dummy snd-soc-dummy: ASoC: dynamically register DAI snd-soc-dummy
kernel: snd_soc_register_dai:2345: snd-soc-dummy snd-soc-dummy: ASoC: Registered DAI 'snd-soc-dummy-dai'
kernel: snd_soc_register_dai:2308: pcm512x 2-004e: ASoC: dynamically register DAI 2-004e
kernel: snd_soc_register_dai:2345: pcm512x 2-004e: ASoC: Registered DAI 'pcm512x-hifi'
kernel: snd_soc_register_dai:2308: pcm512x 2-004c: ASoC: dynamically register DAI 2-004c
kernel: snd_soc_register_dai:2345: pcm512x 2-004c: ASoC: Registered DAI 'pcm512x-hifi'
kernel: davinci-mcasp 48038000.mcasp: IRQ common not found
kernel: snd_soc_register_dai:2308: davinci-mcasp 48038000.mcasp: ASoC: dynamically register DAI 48038000.mcasp
kernel: snd_soc_register_dai:2345: davinci-mcasp 48038000.mcasp: ASoC: Registered DAI '48038000.mcasp'
kernel: davinci_mcasp_get_dma_type:1917: davinci-mcasp 48038000.mcasp: DMA controller compatible = "ti,edma3-tpcc"
kernel: graph_count_noml:527: asoc-audio-graph-card sound: Count As Normal
kernel: graph_count_noml:527: asoc-audio-graph-card sound: Count As Normal
kernel: graph_get_dais_count:609: asoc-audio-graph-card sound: link 2, dais 4, ccnf 0
kernel: graph_dai_link_of:351: asoc-audio-graph-card sound: link_of (/ocp/interconnect@48000000/segment@0/target-module@38000/mcasp@0/port/endpoint@1)
kernel: asoc-audio-graph-card sound: parse error -22
kernel: asoc-audio-graph-card: probe of sound failed with error -22

I have tried to trace this to figure out what's missing/wrong but have been
generally unsuccessful. (The call to asoc_simple_parse_cpu() in
audio-graph-card.c:369 fails with -EINVAL but that is as far as I got.)

Thank you for your time.

-- 
Arvid Brodin
