Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADF85F9FED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJJOKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJJOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:10:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D82165A1;
        Mon, 10 Oct 2022 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665410995; x=1696946995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x2tSxWUuPPP9Zc8so3zHBDreOmvBCXb0WB4eGZauU0c=;
  b=hOurQTeSo/CwFvzi0/eKuw8Gq+mhPkzwWAfh6V9/f7tYlrhSZ8yFT2e/
   Kw65Q6hW5gOclAjJpUlldwGVZdWX8OLNNOh8iUuy/HLUa/96uvJQw3iQ9
   Hm8jdvc8V2t3CRITzEvAwc3SpQEwCdyajYow4QsV+P6+++hXM7wEwVZGo
   YVLw6T02GInlqf8WOhEzvUKzt4UShrdW/wtCK5Gmu+5PwI/4gu262ddac
   cXfYW33h/EGdBMnKSPbb1OMvoa67J/9ylVHBAjsbCi2lMoOJvJ7D/rLZu
   ftURRAA0QUr2ogRe0PKRCP552DCnxv7OXxFgT1dy2/a93eCCU1LdQgoCS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="368369695"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="368369695"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 07:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="730549723"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="730549723"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2022 07:09:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohtT7-004u65-13;
        Mon, 10 Oct 2022 17:09:21 +0300
Date:   Mon, 10 Oct 2022 17:09:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Y0QnkQklBpDdqjpi@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
 <98b59ad5-8c29-be41-4da1-a961db67827c@gmail.com>
 <Y0QIzf2cAH9ehSeO@smile.fi.intel.com>
 <19a6db0f-40a8-dacf-4583-cdb9d74e1243@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a6db0f-40a8-dacf-4583-cdb9d74e1243@fi.rohmeurope.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 01:20:23PM +0000, Vaittinen, Matti wrote:
> On 10/10/22 14:58, Andy Shevchenko wrote:
> > On Mon, Oct 10, 2022 at 12:12:34PM +0300, Matti Vaittinen wrote:
> >> On 10/6/22 21:32, Andy Shevchenko wrote:
> >>> On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:

(Note, everything I have dropped without comment can be treated
 as "yes, I agree on your points". Same applies to the early or
 the future replies.)

...

> >>> Also what will be the module name (see other Kconfig for the pattern)?
> >>
> >> Here the pattern is IMHO improved by cutting the useless text. Even the
> >> cross-reference from SPI to I2C and I2C to SPI driver which was in v1 is
> >> more useful. Module autoloading for SPI should just work. Adding the module
> >> name here seems just a silly habit - which I see many people are breaking.
> >> If module name is to be needed, then it should be checked from the Makefile
> >> and not trusted that Kconfig text stays up-to-date...
> > 
> > I think the module name is a good thing to have for a user who might be
> > not knowing about Makefile:s and how to derive the module name from that
> > (sometimes it's not so obvious).
> 
> My point is that average users do not really even need to know the 
> module names. For most simple drivers the module name is just the base 
> of the filename. I really doubt there are that many people who
> 
> a) do need to know module name

Everyone? When I need to debug the issue (assisted debug or doing myself) it is
often good to know:

 1) is the driver built as a module;
 2) is that module ever loaded;
 3) how to find initial module parameters if any
    (see /sys/module/$NAME/parameters).

> b) read config menu entries but don't know how to find a module name
> from Makefile

Isn't it orthogonal? Average user may easily choose everything in the kernel
configuration via `make menuconfig` because it _is_ user interface / tool.
Makefile simply is not for the users.

> c) want to know module name and can't pair the name from lsmod to module

It's reversed mapping we need.

> d) rather look up the config entry than browse the contents of
> lib/modules/...

So, I have a module called 'foo-bar.ko' and lsmod shows me 'baz-hell'.
How should I know that mapping to begin with?

> It'd be nice to know if anyone reading this mail has actually ever used
> the module name information placed in Kconfig entry for _anything else_
> except for making the Kconfig entry to look a bit more fatty...

That said, I haven't found any good justification from your side to avoid
including the module name, while I see the advantages of otherwise.

...

> >>>> +#include <linux/iio/iio.h>
> >>>> +#include <linux/iio/sysfs.h>
> >>>> +#include <linux/iio/trigger.h>
> >>>> +#include <linux/iio/trigger_consumer.h>
> >>>> +#include <linux/iio/triggered_buffer.h>
> >>>
> >>> Can this group be placed after units.h (with blank line in between)?
> >>
> >> Why? What's wrong with alphabetical order?
> > 
> > Nothing wrong with the order and order is orthogonal to the grouping.
> > My comment is for the latter. The rationale is to easily see generic header
> > group and subsystem related group.
> 
> I can for sure change this but It'd be nice to know why should the 
> subsystem headers be treated differently from the rest of the headers?

Rationale is based on the rule 'generic headers are included first'.
Subsystem's headers can be considered less generic than the rest.

...

> >>>> +struct kx022a_data {
> >>>> +	int irq;
> >>>> +	int inc_reg;
> >>>> +	int ien_reg;
> >>>
> >>>> +	struct regmap *regmap;
> >>>
> >>> Putting this as a first member might improve code by making pointer arithmetics
> >>> better. Have you checked possibilities with bloat-o-meter?
> >>
> >> No. Amount of combinations is just too huge for me to try randomly
> >> reordering structs and running bloat-o-meter. Can you please explain me why
> >> you think reordering this would have visible impact and if this is something
> >> that is universally true or if such an optimization is architecture
> >> dependent?
> > 
> > Usually regmap pointer is used more often than, for instance, the 'irq' member,
> > and I believe that moving 'irq' member deeper will be harmless, while moving
> > regmap might be winning.
> 
> So you suggest us to try optimizing the code by placing a pointer to 
> more frequently used member(s) at the top of the struct? I didn't know 
> it would have any impact. I understand arranging the members of 
> frequently copied structs based on sizes so that we can avoid eating 
> space by padding - but I had never heard of things being improved by 
> ordering based on frequency of use. It'd be great to understand the 
> mechanism this optimization is based on?

It's based on the pointer arithmetics. In some cases it might be a win, in some
actually no advantage, that's why it's hard to say just by looking at the code.

Most affected cases are for the embedded data structures, where container_of()
is used on top, esp. if most used member of those structures are also appeared
first. Often example is:

struct foo {
	struct list_head node;
	...
};

vs.

struct foo {
	...
	struct list_head node;
};

where you may even see by reading the code that list_for_each_entry()
will be shorter.

With pointers it's less visible, but still might have a difference.

> >>>> +	struct iio_trigger *trig;
> >>>> +	bool trigger_enabled;
> >>>> +
> >>>> +	struct device *dev;
> >>>> +	unsigned int g_range;
> >>>
> >>>> +	struct mutex mutex;
> >>>
> >>> No warning from checkpatch? Every lock should be commented what it is for.
> >>
> >> No. I didn't see a warn from checkpatch with v6.0-rc7. And I am glad I
> >> didn't. I am not a fan of statements like "always document a lock" or "never
> >> use a goto" - because blindly following such "rules" tend to lead silly
> >> corner cases. In lock commenting case it is likely to lead copy-pasting
> >> comments for locks which are used for trivial protections. And I am
> >> definitely not a fan of boilerplate.
> > 
> > So, tell then, what is this lock for? How as a code reader I have to know that?
> 
> I can add comment to this lock as it does protect more than one thing 
> (and may not be trivial). But I am not at all sure requiring all locks 
> to be documented will have optimal end-result... And no, I don't think 
> checkpatch in v6.0-rc7 did warn about this lock. Do you think checkpatch 
> has been modified to do that?

In the commit 4a0df2ef4569 ("update checkpatch.pl to version 0.03"):
...
          check that spinlock_t and struct mutex use is commented
...

dated back 2007.

...

> >>>> +
> >>>> +		while (n-- > 0)
> >>>
> >>> while (n--) ? Or why the 0 is ignored?

So, it appears that yours and mine are equivalents, but mine is shorter :-)

...

> >>>> +	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0xff);
> >>>
> >>> GENMASK() ?
> >>
> >> I don't really see a need for GENMASK here. It does not matter what is
> >> written to this register.
> > 
> > Why not 0? At least it will be aligned to the _CLEAR part without need of
> > any comment. Otherwise it sounds like 0xff is special here.
> 
> I can change it to 0 if it pleases the audience :) 0xff was just first 
> thing that came to my mind when I read the spec that something should be 
> written to this register.

At least it will be less confusing in my opinion.

...

> >>>> +	if (en)
> >>>> +		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> >>>> +				       KX022A_MASK_DRDY);
> >>>
> >>> I would put redundant 'else' here to have them on the same column, but
> >>> it's pity we don't have regmap_assign_bits() API (or whatever name you
> >>> can come up with) to hide this kind of code.
> >>
> >> Eh, you mean you would put else here even though we return from the if? And
> >> then put another return in else, and no return outside the if/else?
> >>
> >> I definitely don't like the idea.
> >>
> >> We could probably use regmap_update_bits and ternary but in my opinion that
> >> would be just much less obvious. I do like the use of set/clear bits which
> >> also makes the meaning / "polarity" of bits really clear.
> > 
> > The idea behind is simple (and note that I'm usually on the side of _removing_
> > redundancy)
> > 
> > 	if (en)
> > 		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> > 				       KX022A_MASK_DRDY);
> > 	else
> > 		return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> > 					 ...
> > 
> > Because the branches are semantically tighten to each other. But it's not
> > a big deal to me.
> 
> What I do not really like in above example is that we never reach the 
> end of function body.

What do you mean by that? Compiler does warn or what?

> It is against the expectation - and adding the 
> else has no real meaning when if returns. I actually think that 
> checkpatch could even warn about that construct.

No way we ever accept such a thing for checkpatch because it's subjective
(very dependant on the code piece). OTOH the proposed pattern is used in
many places and left like that in places where I cleaned up the 'else',
to leave the semantic tights with the above lines).

> >>>> +	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> >>>> +				 KX022A_MASK_DRDY);

I see that we have a strong disagreement here. I leave it to maintainers.

-- 
With Best Regards,
Andy Shevchenko


