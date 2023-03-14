Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA46B8C56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCNIAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCNIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:00:35 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F89559F3;
        Tue, 14 Mar 2023 01:00:34 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [IPv6:2a00:d880:11::2cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PbQtm1z9SzyQw;
        Tue, 14 Mar 2023 10:00:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678780832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqqP8dAaTJxKYLVhrLNOji8cK4C0GYGHCgk2k9zgffk=;
        b=e2strcF59Y3e10E9Ij7EiuTGMnKfQLZpWom41hz/11oSnP/wQSswIdw4QyKServQ3acJ6M
        fOHPi5Och13eez6IECXx4BsF0txeBibGHihwqIfxTxkYdUGqiKaBfuYB3VbYUhW4XO0MkH
        jmPF6/F0tY9aJQzFzKcIrD+TCFnWoZI=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678780832; a=rsa-sha256; cv=none;
        b=V4nMlofw/DyZBNt19aj/ZNt0YOeICwkTt8svCkUSf9ljdTEGnPxzVbor7TO5OayX76FEEV
        U4I0LDx6FTHhMW6+2o8FNbAU7iKYrf93fbgr5GQLOJaho62MRsYPrnBhuYFhEz112iDbiQ
        ibwW+1D/Fq/HPCwBHw+oejql7j53zWI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678780832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqqP8dAaTJxKYLVhrLNOji8cK4C0GYGHCgk2k9zgffk=;
        b=or70kB9KhDrbfPj3RyAR1pR+ZNobzxKQumhcTcfwg4LT734J7/++6TlsKI6HlafaTrbbhv
        /lmJD3PkWgKpkxbnYqpcw1G50YtMlcYyo0CbskpDWUu31oQijo8wUT2CQd2fBnaVoVzFol
        VSnyLmwXnGcfnIC8oux4CBnX+ACmCnQ=
Received: from [IPV6:2001:14ba:440a:f000::5] (dktgsyyyyyyyyyyyyyyct-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::5])
        by dungeon.fi (Postfix) with ESMTPSA id BCAA53F371;
        Tue, 14 Mar 2023 10:00:30 +0200 (EET)
Message-ID: <f1e5eb1c-ed1f-96d7-ecf5-69b467ed8339@iki.fi>
Date:   Tue, 14 Mar 2023 10:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313010416.845252-1-kasper@iki.fi>
 <20230314070002.1008959-1-kasper@iki.fi> <ZBAkOr0epPPICLNP@kroah.com>
From:   Jarkko Sonninen <kasper@iki.fi>
In-Reply-To: <ZBAkOr0epPPICLNP@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 09:37, Greg Kroah-Hartman wrote:
> On Tue, Mar 14, 2023 at 09:00:01AM +0200, Jarkko Sonninen wrote:
>> Add support for RS-485 in Exar USB adapters.
>> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
>> Gpio mode register is set to enable RS-485.
>>
>> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
>> ---
>>
>> In this version only rs485.flags are stored to state.
>> There is no locking as only one bit of the flags is used.
>> ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.
> And the difference between previous versions?  Take a look at the
> documentation for how to better describe version differences please.

I'll try to be more precise in the future.

>> +	memset(&rs485, 0, sizeof(rs485));
> But you just copied this from userspace, why zero it out again?  Is that
> to be expected (I really don't remember, sorry).


serial.h says

/*
  * Serial interface for controlling RS485 settings on chips with suitable
  * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by 
your
  * platform. The set function returns the new state, with any 
unsupported bits
  * reverted appropriately.
  */

This may mean only the flags, but I decided to zero the other 
unsupported fields as well.


> Anyway, just minor comments, I'll let others review it as well.
>
> thanks,
>
> greg k-h

     - Jarkko

