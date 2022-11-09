Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99B622BB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKIMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKIMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:36:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B0B175BA;
        Wed,  9 Nov 2022 04:36:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6E96342168;
        Wed,  9 Nov 2022 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1667997402; bh=40T/Vg8S78Ck1klC8rhrSnHnp9uaUuhzNx0JdGvXxQQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=LvBU1vt/QEhtDus5QTiUFIqeeLClAamWy5/sfF3m/akhhilFMmBLbEQ9yiOJWmLPT
         g4H5v0GL2Gr+kcLJCA9mlKagmPpAcBsSVAKu8+DG+ze1XyUixA/s18wnZl6jWUVTJV
         6AmargetRQOrnuWOF/8VGg6cBbk7NtlerAU4WilSxMWjzMuK7wKIqJ0bsjAYSP6AAM
         JXj8jfJD5R4Sh1uTIzd+kjMr2pyIzhBaT5rB6Su5nJ5+29BaJmQO+BM95EWqCnovVe
         aUJNpR5WBOcL7F536YPC4fhJwiGU7ElAZ3y8/to9vNRqOY5DEMnICq41WzTNDEM8s1
         qMcwQSUcblisg==
Message-ID: <c3b88bae-f6da-4242-0b19-5e2a32b9c266@marcan.st>
Date:   Wed, 9 Nov 2022 21:36:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-5-marcan@marcan.st>
 <20221102061819.dyl5ah6qffntqieh@vireshk-i7>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 4/5] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
In-Reply-To: <20221102061819.dyl5ah6qffntqieh@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 15.18, Viresh Kumar wrote:
> On 24-10-22, 13:39, Hector Martin wrote:
>> +const struct apple_soc_cpufreq_info soc_t8103_info = {
> 
> static ? For other instances too.

Ack, fixed.

>> +static const struct of_device_id apple_soc_cpufreq_of_match[] = {
>> +	{
>> +		.compatible = "apple,t8103-cluster-cpufreq",
>> +		.data = &soc_t8103_info,
>> +	},
>> +	{
> 
> Isn't the preferred way for this is "}, {" instead ?
> 
> I couldn't find this in Coding Guidelines, but somehow remember that
> to be the preferred format.

I did an informal search and the two-line form seems to be more common,
though both are in widespread use. I can change it if you want, though
it seems kind of a wash.

>> +static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
>> +{
>> +	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
>> +	struct apple_cpu_priv *priv = policy->driver_data;
>> +	unsigned int pstate;
>> +	unsigned int i;
> 
> Merge these two ?

Done.

> 
>> +
>> +	if (priv->info->cur_pstate_mask) {
>> +		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
>> +
>> +		pstate = (reg & priv->info->cur_pstate_mask) >>  priv->info->cur_pstate_shift;
>> +	} else {
>> +		/*
>> +		 * For the fallback case we might not know the layout of DVFS_STATUS,
>> +		 * so just use the command register value (which ignores boost limitations).
>> +		 */
>> +		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_CMD);
>> +
>> +		pstate = FIELD_GET(APPLE_DVFS_CMD_PS1, reg);
>> +	}
>> +
>> +	for (i = 0; policy->freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
> 
> You may want to use, cpufreq_for_each_valid_entry(), or some other
> generic iterator here.

Done.

>> +	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> 
> Why do you need this ? The OPP core should be able to find this
> information by itself in your case AFAIU. The OPP core will refer
> "operating-points-v2 = <&pcluster_opp>" and find that the cores are
> related.

We have multiple clusters sharing an OPP table (e.g. the M1 Ultra has 2
e-cluster and 4 p-clusters, and duplicating OPP tables seems very
silly), so this is necessary to tell it about the subset of cores
sharing a table that are actually one domain.

> 
>> +	if (ret) {
>> +		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n", __func__, ret);
>> +		goto out_iounmap;
>> +	}
>> +
>> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
>> +	if (ret <= 0) {
>> +		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> 
> Why would this happen in your case ?

Good question. This came from scpi-cpufreq.c. It sounds like it doesn't
make any sense here; the error path should just error out, not defer.
I'll change it to that.

>> +		ret = -EPROBE_DEFER;
>> +		goto out_free_opp;
>> +	}
>> +
>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +	if (!priv) {
>> +		ret = -ENOMEM;
>> +		goto out_free_opp;
>> +	}
>> +
>> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>> +	if (ret) {
>> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
>> +		goto out_free_priv;
>> +	}
>> +
>> +	/* Get OPP levels (p-state indexes) and stash them in driver_data */
>> +	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
>> +		unsigned long rate = freq_table[i].frequency * 1000;
>> +		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
> 
> Shouldn't you use dev_pm_opp_find_freq_exact() here ?

Actually, it would seem the correct thing to do is
dev_pm_opp_find_freq_ceil, or otherwise use _floor and add 999.
dev_pm_opp_init_cpufreq_table() truncates down to kHz, so the real
frequency will always be between `rate` and `rate + 999` here. This
makes it work with frequencies that aren't a multiple of 1 kHz (we don't
have any of those but it seems broken not to support it).

- Hector
