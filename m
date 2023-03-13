Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDFD6B7B85
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCMPIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCMPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:08:16 -0400
X-Greylist: delayed 50576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 08:08:09 PDT
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB97E05A;
        Mon, 13 Mar 2023 08:08:08 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [IPv6:2a00:d880:11::2cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Pb0QW02mGzyRf;
        Mon, 13 Mar 2023 17:08:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678720083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZR0dDzmhfTt6svxrNpJJLMD649AI6rRZ9XzVQhKkocw=;
        b=QwujIY3gcFI4h9/3VptGQg2jaHWQzm+CmufKm9Jb4Oni8YNP6NgwTOGImbBV7q9dWoj+bK
        gM2/JY2K5FrxqeZ7M9d61RT7MmWoLW4nAhtDMoyIYxdeS6jHGEBX50S1YFVWSqNdDtM7U4
        zFOcZ/TzLigFsxHlHY3pIR1CeyKN47A=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678720083; a=rsa-sha256; cv=none;
        b=dk0ML6qHDfCYl/YOd8iF9cv5C93xii3aaimYSO24kwLmrAg4UiQaTF98LSgr96SN/LF6DT
        +53MHsJmbn4k8o1isF7epPL5MvGDwuc6/rl49nx2K1mVwKXK5rKFklg+D4/UOamCTX4h8k
        yrFFeF3VpbR6AKKZaHrH7EH8o2/sdbI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678720083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZR0dDzmhfTt6svxrNpJJLMD649AI6rRZ9XzVQhKkocw=;
        b=mRKY5pSN3ss41D+ma2SWXFF6v/MU/k1VUrlQZIbVoqVOXJoUn8CaGsoKKPkUuDRPrldyDD
        UAAkZy1297nHiHbboSJ5EJpD9jJfGmSLpSdfO/KOAQyrR9DxdbiPNSK7MWzvIjWBFOoHJi
        EOKTCA0lttSPQzPbDnDDUgRYJqIal8c=
Received: from [IPV6:2001:14ba:440a:f000::3] (dktgsyyyyyyyyyyyyyybt-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::3])
        by dungeon.fi (Postfix) with ESMTPSA id F1F613F270;
        Mon, 13 Mar 2023 17:08:00 +0200 (EET)
Message-ID: <71fd009b-8378-d5b0-5243-5279b2b880ee@iki.fi>
Date:   Mon, 13 Mar 2023 17:07:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313010416.845252-1-kasper@iki.fi>
 <ZA7KIs2jA/acpN9n@kroah.com> <a1ba59be-30aa-08e9-65e7-2c458cc164f9@iki.fi>
 <ZA7Wh2Z/DdKOsOYr@kroah.com>
From:   Jarkko Sonninen <kasper@iki.fi>
In-Reply-To: <ZA7Wh2Z/DdKOsOYr@kroah.com>
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

On 3/13/23 09:53, Greg Kroah-Hartman wrote:
> On Mon, Mar 13, 2023 at 09:49:26AM +0200, Jarkko Sonninen wrote:
>>>> +{
>>>> +	void __user *argp = (void __user *)arg;
>>>> +
>>>> +	switch (cmd) {
>>>> +	case TIOCGRS485:
>>>> +		return xr_get_rs485_config(tty, argp);
>>>> +	case TIOCSRS485:
>>>> +		return xr_set_rs485_config(tty, argp);
>>>> +	}
>>>> +	return -ENOIOCTLCMD;
>>> Wrong ioctl return value :(
>> What is the correct ioctl error return value ?
>> ENOIOCTLCMD was used in most places in usb serial as an error return.
> ENOTTY is the correct one for when an ioctl is not handled by the ioctl
> call.
>
> thanks,
>
> greg k-h

Using ENOTTY breaks all other tty ioctls.

     - Jarkko

