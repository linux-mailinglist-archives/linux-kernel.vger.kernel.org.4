Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44146747E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjATAPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjATAPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:15:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE01A296B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 16:15:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674173705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8LqwXu5N/XTWGs4+/Z4tXzItJ00/1ZndX0/k1rrP8E=;
        b=eKlEnIkTdKjtGT69E8Z6QJ7MFm40+hR7iuL6Bd/6NHrr4anJHpV/P+NrwoXigo9dWxsLSb
        u7w47EdwWcROXZAcyZx9c0XF6t46aCN3srO3K+4SNKMgbDeLkHLhwdux4l+0B6TmbkwnXd
        DIak/t5TIyoA6CoJYbFoGsb54z5Ld2M48vJyQBCezfrRbq63h3qIck1gtcOeRePleEnKY+
        YVJ0V4Lb5pQAkm6G/LOqjkOOy8DFtNCCw0F+cKW7sKde8559IlwaJXHgrS+swnUhTPXMfp
        oApjcvqZj2mzhXf/dkeaqktSVET42KMsGp38u1v6nhL6zUea4XGzugsoebvytA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674173705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G8LqwXu5N/XTWGs4+/Z4tXzItJ00/1ZndX0/k1rrP8E=;
        b=1/LT9TlvZ1s6nN1Ct1cf9Fc9ceE6t8k/2mGxLjs/Wu7vSnhus6qeB7Kk+N5hkxOhcREYKa
        rJrSTib8/3z7owCg==
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v1 Part2 3/5] x86/microcode: Add a generic mechanism to
 declare support for minrev
In-Reply-To: <20230113172920.113612-4-ashok.raj@intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
 <20230113172920.113612-4-ashok.raj@intel.com>
Date:   Fri, 20 Jan 2023 01:15:04 +0100
Message-ID: <87y1pygiyf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok!

On Fri, Jan 13 2023 at 09:29, Ashok Raj wrote:
> Intel microcode adds some meta-data to report a minimum required revision
> before this new microcode can be safely late loaded. There are no generic

s/this new microcode/a new microcode revision/

Changelogs are not restricted by twitter posting rules.

> mechanism to declare support for all vendors.
>
> Add generic support to microcode core to declare such support, this allows
> late-loading to be permitted in those architectures that report support
> for safe late loading.
>
> Late loading has added support for
>
> - New images declaring a required minimum base version before a late-load
>   is performed.
>
> Tainting only happens on architectures that don't support minimum required
> version reporting.
>
> Add a new variable in microcode_ops to allow an architecture to declare
> support for safe microcode late loading.
> @@ -487,13 +488,22 @@ static ssize_t reload_store(struct device *dev,
>  	if (ret)
>  		goto put;
>  
> +	safe_late_load = microcode_ops->safe_late_load;
> +
> +	/*
> +	 * If safe loading indication isn't present, bail out.
> +	 */
> +	if (!safe_late_load) {
> +		pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
> +		pr_err("You should switch to early loading, if possible.\n");
> +		ret = -EINVAL;
> +		goto put;
> +	}
> +
>  	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
>  	if (tmp_ret != UCODE_NEW)
>  		goto put;
>  
> -	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
> -	pr_err("You should switch to early loading, if possible.\n");
> -

Why are you not moving the pr_err()s right away (in 1/5) to the place
where you move it now?

>  	mutex_lock(&microcode_mutex);
>  	ret = microcode_reload_late();
>  	mutex_unlock(&microcode_mutex);
> @@ -501,11 +511,16 @@ static ssize_t reload_store(struct device *dev,
>  put:
>  	cpus_read_unlock();
>  
> +	/*
> +	 * Only taint if a successful load and vendor doesn't support
> +	 * safe_late_load
> +	 */
> +	if (!(ret && safe_late_load))
> +		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);

The resulting code is undecodable garbage. Whats worse is that the
existing logic in this code is broken already.

#1
	ssize_t ret = 0;

This 'ret = 0' assignment is pointless as ret is immediately overwritten
by the next line:

	ret = kstrtoul(buf, 0, &val);
	if (ret)
		return ret;

	if (val != 1)
		return size;

Now this is really useful. If the value is invalid, i.e. it causes the
function to abort immediately it returns 'size' which means the write
was successful. Oh well.

Now lets look at a few lines further down:

#2

	ssize_t ret = 0;
        ...
        ret = check_online_cpus();
	if (ret)
		goto put;
        ...
put:
        ...
	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
        ...
        return ret;

Why are we tainting the kernel when there was absolutely ZERO action
done here? All what check_online_cpus() figured out was that not enough
CPUs were online, right? That justfies a error return, but the taint is
bogus, no?

The next bogosity is:

	ssize_t ret = 0;
        ...
        tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
	if (tmp_ret != UCODE_NEW)
		goto put;
        ...    
put:
        ...
	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);

	if (ret == 0)
		ret = size;

        return ret;

IOW, the microcode request can fail for whatever reason and the return
value is unconditionally 'size' which means the write to the sysfs file
is successfull.

#3

Not to talk about the completely broken error handling in the actual
microcode loading case in __reload_late()::wait_for_siblings code path.

Maybe more #...

How does any of this make sense and allows sensible scripting of this
interface?

Surely you spent several orders of magnitude more time to stare at this
code than I did during this review, no?

Now instead of noticing and fixing any of this nonsense you are duct
taping this whole safe_late_load handling into that mess to make it even
more incomprehensible.

If you expected an alternative patch here, then I have to disappoint
you.

I'm not presenting you the proper solution this time on a silver tablet
because I'm in the process of taming my 'let me fix this for you' reflex
to prepare for my retirement some years down the road.

But you should have enough hints to fix all of this for real, right?

Thanks,

        tglx
