Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340B6BCCF9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCPKiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCPKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:38:03 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65172E0D7;
        Thu, 16 Mar 2023 03:37:53 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PckHM1s82z49Q6Y;
        Thu, 16 Mar 2023 12:37:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678963071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jixm8SbZkD0ywJUAT0N7QW8GJMa8mSiakLcnCyMlqCc=;
        b=vsB5h3yBMXtjlBsPHT+OyXjS8o71MHU/UX5BT75zdhSfcZUNl19sFYuVHhsI7pHEnetfjt
        RPddE5XWJlIrS0JXt3B3cdSs8ikCOnBOga5yoqTq+ufC8TkmjsI1wCQHBmh3d7c5H7sOYF
        793jiw2pJMtBZ29gknEEkmzBRz9rwp2skmmhF+ifvfU/RxWhppbqqVBl7m4AyAFx/fu/9o
        yjc63rhKgC4tuV+LXMsKgTTYF3AwuRsSGHdFF6YdzYPrrFwdKvKD2opIcHEVy/4Lu1cALh
        dXhby23qvG+XTTtAqIRvC+CUbNTHFoLw2Ob0zQ+QgT9UcIhmxzDH+BBFZgpJ7Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678963071; a=rsa-sha256;
        cv=none;
        b=oCIiPdyFZhtE+jMnq+1dYPmmqdFHaXyxm/mGibQ8JGHWePDmblA2PvUOq4G8PF7VgiD01l
        dmExRMHmtd2uztJevuI+Ec/S0brt5Inmu7JFWqlvlqZUxgeQwg1NBzB6LFjvUlhc/ONpk+
        anK9zXBwptgpKYO7btBFom7ybYuNg7DRFxjdoc+vXEvaq4wk4GO3DDq5Nbo746Y4W49LtM
        GGYz9wg4tKhTsJ0zKRcsJTUAcQyRiIjAEmF1FT0XKvDVYC/xB4QB2Fz++CnDlC6kkpbDYc
        kl7D+pL3t6eCb/D+1+iesDDHdPcCmxN3c8Trlg00YoX3cNqdwzTCWizt4V+cMg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678963071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jixm8SbZkD0ywJUAT0N7QW8GJMa8mSiakLcnCyMlqCc=;
        b=t9gbAOw6Qlct2biN3NgDhjJVESCgsYieurlQ4+M+goRBn6crII0oMjCExAct7P9XhBFVUF
        wANIfjaTU6yXaobQ6MD3ZbGc0oEdYMX7uGHQLsqCEREw5EyYmRxEVIlYWxrl+vL0my8cE3
        E+vZR//CH3U7E6azjG5yCvhkJbmvU1q+ny6JaTvqCM2IHhddEVHZ7o7Hr1nVrg/9P7fYzp
        G6XiWBfNOgtZ/Vfl0h4fO6bbVHs7shoG7RP7lMBGyC4eVMhJysdo/aIihpNk0effSV2mcB
        XRztVLaRpu16tSmK9d3wfdspVa7His4YvVRmIFCDzOfbEc2dLIWis+9DKpEkNg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 0AA49634C91;
        Thu, 16 Mar 2023 12:36:40 +0200 (EET)
Date:   Thu, 16 Mar 2023 12:36:40 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCHv3 1/2 RESEND] doc/media api: Try to make enum usage
 clearer
Message-ID: <ZBLxOEt2KDLxOMo0@valkosipuli.retiisi.eu>
References: <20230219120034.5819b4ac.dorota.czaplejewicz@puri.sm>
 <ZBGahMbA1fBrKLYP@valkosipuli.retiisi.eu>
 <20230315140914.707e0cc9.dorota.czaplejewicz@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315140914.707e0cc9.dorota.czaplejewicz@puri.sm>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dorota,

On Wed, Mar 15, 2023 at 02:09:14PM +0100, Dorota Czaplejewicz wrote:
> Hi,
> 
> On Wed, 15 Mar 2023 12:14:28 +0200
> Sakari Ailus <sakari.ailus@iki.fi> wrote:
> 
> > Hi Dorota,
> > 
> > On Sun, Feb 19, 2023 at 12:00:34PM +0100, Dorota Czaplejewicz wrote:
> > > This clarifies which side of the calls is responsible for doing what to which parts of the struct.
> > > This also explicitly states that repeating values are disallowed.
> > > It also expands the terse description of the access algorithm into more prose-like, active voice description, which trades conciseness for ease of comprehension.  
> > 
> > The commit message lines should be wrapped at 74 characters. Please do use
> > checkpatch.pl in the future. There is also no apparent reason to add a
> > newline after a period.
> > 
> > The same applies to the other patch as well.
> > 
> > I've addressed the issues this time.
> 
> Thanks for taking a look. What is the next step?

Just remember to use checkpatch.pl, on media tree in particular it's:

	$ checkpatch.pl --strict --max-line-length=80

-- 
Sakari Ailus
