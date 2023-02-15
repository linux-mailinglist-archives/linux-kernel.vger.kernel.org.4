Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033C0698175
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjBOQ6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBOQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:58:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38B8227AC;
        Wed, 15 Feb 2023 08:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676480327; x=1708016327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=YKF6ZvLA3d1uM5u+HATdtClSHQTuSkgIY/ovoaUK2AI=;
  b=IWQSSMw4H5DuBkZMrgnl0I2w4J4QQ4KoLhq2SVyPmOpaxKjtx0XrOcKu
   WC9fdc18gq5GwRIeiFHte6DPiRAojo9LxWKeEBcy2B4QB0ljbrKrPs2J5
   o/LVoIgY7bKMNRS86BiiUrelbS8A0SCfHQiQaYj/UFFwZOuBQX6v2tRxL
   cZFB3OtZ16dD+6OBmQDD3uzOuimkf5b/QnqtVg6pVGU/mZEVGGHtLDf3N
   yAMAc3uNnBepQ1PtsOUg0OR6wuDJyPkAsLxYPrg3AHmbEN18y+0sV0BPV
   pdbdsUO5A3E6GcdcoC3WsaJgu7LEiqFRm0YZMwTqzO4Ii9kpfv1NGguZF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311845718"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="311845718"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 08:58:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="702139634"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="702139634"
Received: from chakanog-mobl.amr.corp.intel.com (HELO [10.209.64.107]) ([10.209.64.107])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 08:58:45 -0800
Content-Type: multipart/mixed; boundary="------------2vfOd79GQan17WCFyyEr3R4L"
Message-ID: <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
Date:   Wed, 15 Feb 2023 08:58:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230214234426.344960-5-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2vfOd79GQan17WCFyyEr3R4L
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/23 15:44, Jithu Joseph wrote:
> +/* MSR_ARRAY_BIST bit fields */
> +union ifs_array {
> +	u64	data;
> +	struct {
> +		u32	array_bitmask		:32;
> +		u32	array_bank		:16;
> +		u32	rsvd			:15;
> +		u32	ctrl_result		:1;
> +	};
> +};

Wow, after all that, the bitfield remains!  Even the totally unnecessary
parts, like the 32-bit wide bitfield in the 32-bit value.  The *LEAST*
you can do is this:

	struct ifs_array {
		u32	array_bitmask;
		u16	array_bank
		u16	rsvd			:15;
		u16	ctrl_result		:1;
	};

to at least minimize the *ENTIRELY* unnecessary bitfields.  I'm also not
quite sure why I'm going to the trouble of writing another one of these
things since the last set of things I suggested were not incorporated.
Or, what the obsession is with u32.

I also think the union is a bit silly.  You could literally just do:

	msrvals[0] = (u64 *)&activate;
or
	memcpy(&msrvals[0], &activate, sizeof(activate));

and probably end up with exactly the same instructions.  There's no type
safety here either way.  The cast, for instance, at least makes the lack
of type safety obvious.

> +static void ifs_array_test_core(int cpu, struct device *dev)
> +{
> +	union ifs_array activate, status = {0};

So, 'status' here is initialized to 0.  But, 'activate'... hmmm

Here's 1 of the 4 fields getting initialized:

> +	activate.array_bitmask = ~0U;
> +	timeout = jiffies + HZ / 2;
> +
> +	do {
> +		if (time_after(jiffies, timeout)) {
> +			timed_out = true;
> +			break;
> +		}
> +
> +		msrvals[0] = activate.data;

and then the *WHOLE* union is read here.  What *is* the uninitialized
member behavior of a bitfield?  I actually haven't the foggiest idea
since I never use them.  Is there some subtly C voodoo that initializes
the other 3 fields?

BTW, ifs_test_core() seems to be doing basically the same thing with
ifs_status.

> +		atomic_set(&array_cpus_out, 0);
> +		stop_core_cpuslocked(cpu, do_array_test, msrvals);
> +		status.data = msrvals[1];
> +
> +		if (status.ctrl_result)
> +			break;
> +
> +		activate.array_bitmask = status.array_bitmask;
> +		activate.array_bank = status.array_bank;
> +
> +	} while (status.array_bitmask);
> +
> +	ifsd->scan_details = status.data;

Beautiful.  It passes raw MSR values back out to userspace in sysfs.

OK, so all this union.data nonsense is to, in the end, pass two MSR
values through an array over to the do_array_test() function. That
function, in the end, just does:

+	if (cpu == first) {
+		wrmsrl(MSR_ARRAY_BIST, msrs[0]);
+		/* Pass back the result of the test */
+		rdmsrl(MSR_ARRAY_BIST, msrs[1]);
+	}

with them.  It doesn't even reuse msrs[0].  It also doesn't bother to
even give them symbolic names, like command and result.  The msrs[]
values are also totally hard coded.

I'd probably do something like the attached patch.  It gets rid of
'data' and uses sane types for the bitfield.  It does away with separate
variables and munging into/out of the msr[] array and just passes a
single command struct to the work function.  It doesn't have any
uninitialized structure/bitfield fields.

Oh, and it's less code.

> +	if (status.ctrl_result)
> +		ifsd->status = SCAN_TEST_FAIL;
> +	else if (timed_out || status.array_bitmask)
> +		ifsd->status = SCAN_NOT_TESTED;
> +	else
> +		ifsd->status = SCAN_TEST_PASS;
> +}
> +
>  /*
>   * Initiate per core test. It wakes up work queue threads on the target cpu and
>   * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
> @@ -253,6 +341,8 @@ int do_core_test(int cpu, struct device *dev)
>  		ifs_test_core(cpu, dev);
>  		break;
>  	case IFS_ARRAY:
> +		ifs_array_test_core(cpu, dev);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}

--------------2vfOd79GQan17WCFyyEr3R4L
Content-Type: text/x-patch; charset=UTF-8; name="ifs-fun.patch"
Content-Disposition: attachment; filename="ifs-fun.patch"
Content-Transfer-Encoding: base64

IGlmcy5oICAgICB8ICAgMTMgKysrKystLS0tLS0tLQogcnVudGVzdC5jIHwgICAzNCArKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDIwIGlu
c2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQo=

--------------2vfOd79GQan17WCFyyEr3R4L--
