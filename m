Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA15FEEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJNNeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJNNee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:34:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C019C217;
        Fri, 14 Oct 2022 06:34:27 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MpnPr2WxPz6H73n;
        Fri, 14 Oct 2022 21:32:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 15:34:25 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 14:34:24 +0100
Date:   Fri, 14 Oct 2022 14:34:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221014143423.00000379@huawei.com>
In-Reply-To: <10c4663b-dd65-a545-786d-10aed6e6e5e9@fi.rohmeurope.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
        <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
        <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
        <98b59ad5-8c29-be41-4da1-a961db67827c@gmail.com>
        <Y0QIzf2cAH9ehSeO@smile.fi.intel.com>
        <19a6db0f-40a8-dacf-4583-cdb9d74e1243@fi.rohmeurope.com>
        <Y0QnkQklBpDdqjpi@smile.fi.intel.com>
        <10c4663b-dd65-a545-786d-10aed6e6e5e9@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


...

> >   
> >>>>>> +	if (en)
> >>>>>> +		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> >>>>>> +				       KX022A_MASK_DRDY);  
> >>>>>
> >>>>> I would put redundant 'else' here to have them on the same column, but
> >>>>> it's pity we don't have regmap_assign_bits() API (or whatever name you
> >>>>> can come up with) to hide this kind of code.  
> >>>>
> >>>> Eh, you mean you would put else here even though we return from the if? And
> >>>> then put another return in else, and no return outside the if/else?
> >>>>
> >>>> I definitely don't like the idea.
> >>>>
> >>>> We could probably use regmap_update_bits and ternary but in my opinion that
> >>>> would be just much less obvious. I do like the use of set/clear bits which
> >>>> also makes the meaning / "polarity" of bits really clear.  
> >>>
> >>> The idea behind is simple (and note that I'm usually on the side of _removing_
> >>> redundancy)
> >>>
> >>> 	if (en)
> >>> 		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> >>> 				       KX022A_MASK_DRDY);
> >>> 	else
> >>> 		return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> >>> 					 ...
> >>>
> >>> Because the branches are semantically tighten to each other. But it's not
> >>> a big deal to me.  
> >>
> >> What I do not really like in above example is that we never reach the
> >> end of function body.  
> > 
> > What do you mean by that? Compiler does warn or what?  
> 
> I don't know if compiler warns about it as I didn't test it. Now that 
> you mentioned it, I think I have seen such warnings from a compiler or 
> some static analyzer (klocwork?) in the past though. What I mean is that:
> 
> int foo()
> {
> 	if () {
> 		...
> 		return 1;
> 	} else {
> 		...
> 		return 2;
> 	}
> }
> 

For reference, this is the one I'd write if both options are good
(or both are bad) and we don't need to worry about reducing indent
for readability.

However, I long since decided this was trivial enough not to
comment on it in the code of others!

> construct makes mistakes like:
> 
> int foo()
> {
> 	if () {
> 		...
> 		return 1;
> 	} else {
> 		...
> 		return 2;
> 	}
> 
> 	...
> 
> 	return 0;
> }

That should given unreachable code warning unless you've really managed
to confuse the compiler  / static analysis tooling.

> 
> easy to make. When one uses:
> 
> int foo()
> {
> 	if () {
> 		...
> 		return 1;
> 	}
> 
> 	...
> 	return 2;
> }
> 
> to begin with there is zero room for such confusion.
> 
> >   
> >> It is against the expectation - and adding the
> >> else has no real meaning when if returns. I actually think that
> >> checkpatch could even warn about that construct.  
> > 
> > No way we ever accept such a thing for checkpatch because it's subjective  
> 
> Eh. Are you telling me that there is no subjective stuff in checkpatch? ;)
> 
> > (very dependant on the code piece). OTOH the proposed pattern is used in
> > many places and left like that in places where I cleaned up the 'else',
> > to leave the semantic tights with the above lines).
> >   
> >>>>>> +	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> >>>>>> +				 KX022A_MASK_DRDY);  
> > 
> > I see that we have a strong disagreement here. I leave it to maintainers.  
> 
> 
> Okay, let's hear what others have to say here.

Non answer above ;)

Time for the old "Don't let perfect be the enemy of good!"


> 
> Thanks for all the input this far.
> 
> Best Regards
> 	-- Matti
> 

