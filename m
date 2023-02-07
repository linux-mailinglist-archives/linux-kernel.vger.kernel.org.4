Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BF568D457
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjBGKdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjBGKdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:33:40 -0500
Received: from mail.multiname.org (h4.multiname.org [94.130.68.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05738526A;
        Tue,  7 Feb 2023 02:33:23 -0800 (PST)
Received: from webmail.multiname.org (unknown [10.0.10.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.multiname.org (Postfix) with ESMTPSA id 4P9zx24dG7zPLtYq;
        Tue,  7 Feb 2023 11:33:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ccbib.org; s=20220806;
        t=1675765990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IH4m9/aT70CL9qCSU6oRU8toMh0R6PwiQAQjFw7f5D8=;
        b=Ew+bc/YPk9F3k1BsTsq0B4A4p0+ClwA6NJkd0x+a4YIWnLtWLg9hs2YzANA8F6kPMBZVG5
        gKRUWAtIECRB7WTX6C7kb0EJYNOwNfpY+ugjG+45ELtEqxqic5f7t1kD2O+nXBW/D+d/A+
        A3Hx8uiGgmUjnKR1fKwtVsqziZnDxvJFSlAftimx901A6ja8yuIx9gREn/vaJvfJhDvPfY
        objzHwK8tolsIgOR3fW5jFc7s3kLP9FBSlK0WLJwcIRHjWaZslO2MHRdoQZdWLYHI6qGjl
        b4K2UrVw4ehxBzvbb4684Gw3pIqto7BxGQabWhX8h3rILqXWPyasLNFGvQUGhhI3DeElgp
        m2+Wk5U50uRrDYqkWLJvEZIoRMSFvZhJPR2PpQPhS8z8E6bBhGcmjSw5xrhVj/fvuNP9sE
        FBTKtz0DPatYKrQk3dSqsxSD7Cp7WL7ZrpwpKSoqTZpO1rrIhZ4c1zSvJMQy/GvR+ezFEE
        HzKjWeLne0YHMUbmUVya9LCfgWkBkdgWAGmrL/tuoMjGeyoYPntS51FFZ22SRdprOCyeez
        jBIIaqsjYN7y2f+CtwHCY8AEtHUagD0dDSCJKx6No+HKTa+XzG8qVYRAKGKfJgFbdWDLsG
        PTiAXkUc1nHfYxFKWS5qDzGxFj5Nf8VEkammEZCwIBpI2BBwpW4E0=
MIME-Version: 1.0
Date:   Tue, 07 Feb 2023 11:33:10 +0100
From:   harald@ccbib.org
To:     pelzi@flying-snail.de
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dht11: Read bit stream from IRQ on falling edges
 only
In-Reply-To: <e1acd14e-400b-8896-bdc1-0b364cc52198@feldner-bv.de>
References: <Y9a0RZ+inWs44Kn8@debian-qemu.internal.flying-snail.de>
 <20230130202216.42034309@jic23-huawei>
 <45efc11e5b4cdba3766f19190bb65840@ccbib.org>
 <e1acd14e-400b-8896-bdc1-0b364cc52198@feldner-bv.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ac9ab2224ad19ac606de38fa474dce0c@ccbib.org>
X-Sender: harald@ccbib.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-05 21:41, pelzi@flying-snail.de wrote:
> Following up on Harald's remark, I can provide some first comparison
> data indeed:
> 
> Am 31.01.23 um 10:44 schrieb harald@ccbib.org:
>> This seems like a really small benefit. And we would lose the
>> low state timings in debug output, which I personally find quite
>> convenient. Unless there is data, that this change actually improves
>> something for somebody, I'd reject it.
> 
> Running test script against the original kernel module (see below where 
> on):
> 
> #     real [s]    user [s]  sys [s]  success fails  err per succ
> 1     222,068     0,515     0,506     83     96     115,66 %
> 2     223,152     0,603     0,493     86     99     115,12 %
> *3*   223,502     0,563     0,411     91     68     74,73 %
> *4*   209,626     0,431     0,189     100    15     15,00 %
> *5*   209,689     0,46      0,193     100    19     19,00 %
> *6*   220,35      0,413     0,315     100    35     35,00 %
> 
> 
> Running the patched module:
> 
> # 	Real 	User 	Sys 	Successes 	Failures 	Error rate
> 1 	223,061 	0,459 	0,258 	88 	25 	28,41 %
> 2 	222,431 	0,561 	0,367 	75 	57 	76,00 %
> 3 	225,675 	0,436 	0,178 	92 	19 	20,65 %
> 4 	222,746 	0,444 	0,194 	98 	23 	23,47 %
> 5 	222,668 	0,416 	0,205 	97 	20 	20,62 %
> *6* 	204,126 	0,34 	0,138 	100 	0 	0,00 %
> *7* 	210,495 	0,393 	0,199 	100 	16 	16,00 %
> *8* 	212,563 	0,447 	0,139 	100 	19 	19,00 %
> 
> All tests run on the same board, Allwinner H3 sold as BananaPi M2 Zero,
> under kernel 6.2.0-rc5+. The devicetree overlay is setting the
> input-debounce property of &pio to 5µs, or, because of the excessive
> error rates of the original driver in this configuration, to 1µs (lines
> marked with an asterisk).
> 
> The test simply tries to read temperature and humidity from the 
> IIO/dht11
> exposed input files every 2 seconds, immediately repeating after an 
> error.
> 
> Real/User/Sys is determined by good ol' time command, successes and
> failures are counted by the test script.
> 
> Two aspects strike:
> 
> 1) the patched version of the driver is working satisfactory even with
> 5µs input-debounce filter, where the original driver shows more failed
> than successful reads in this configuration.
> 
> 2) The error rate is consistently lower with the patched driver
> (67,9% to 33,8% average)
> 
> I believe to see similar results, i.e. a noticable improvement on the 
> error
> rate, on my old trusted RaspberryPi 2B (without any devicetree 
> fiddling, of
> course), however without quantitative comparison and based on some 
> Raspbian
> patch level rather than based on kernel 6.2.0-rc5+.
> 
> Of course I have only access to a handful of DHT22 devices, most 
> probably
> from the same production batch. But I think at least I'd like to stick
> with the patched version, tbh.

Aside from different chips (and mostly the old DHT11) there are many 
things,
that influence timing: cable lenght, input characteristic etc.

It looks good, but we should still be careful.

> Hope this helps, let me know if it'd pay to work on another version of
> the patch!

Thanks, these are indeed interresting results. If you want to move this
forward, the next steps would be:
1) Sharing your test script - yes it's trivial, but still ...
2) A theoretical analysis about possible regressions depending on timer
resolution as mentioned in an earlier message.
3) Ideally figuring out, why your version performs better then what we
currently have. I have some suspicions, but better understanding might
lead to a better approach. E.g. maybe recording the other edges isn't
the problem so long as we ignore them during decoding?

As I see it, the main thing we are losing with your current proposal is
some diagnostic features. If we keep them as much as possible and have
regressions understood and covered, I see no reason to reject your idea.

best regards,
Harald

> Best wishes
> 
> Andreas
