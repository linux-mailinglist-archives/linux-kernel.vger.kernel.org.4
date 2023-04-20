Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7650A6E963B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjDTNtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDTNtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:49:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92E65245;
        Thu, 20 Apr 2023 06:49:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-517c01edaaaso763408a12.3;
        Thu, 20 Apr 2023 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681998547; x=1684590547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wnjUcH5y1Pb8R4/f3gZ/CX/Eqa1ZM5qT0lnDQJSddVI=;
        b=ppBsWpCXOkPI9VqP8f0CZnLVdZL6ouH7XsmTPYI2heigN9JKfbVzxPgw5dA17iUhDA
         8g1djWzw5GXkFikwzYddWzDRYS9hDRMhWXqly6PRWF4z3cfzFTmpUFUm9aeQ1pRKAX0H
         JRH/zWEA0R9MPsBUCdF0fGRZe4uRkQG0AIdoD1TfB7x4ufQ/sM0+TplNeWvfCBLdkcPy
         TEvJfY3x8aHbyB4VEdJaCGy5p5PDua+7O0Psq/TmbZxgd0cuJs9fV0Ev42zNLYlzwz0Y
         OqlkUjGi6YmUq9ily1EzjFuYrHYxusN8+X732ZCMRpQP3xE1QoJGSqN87RzJrgeAUYqM
         PBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681998547; x=1684590547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnjUcH5y1Pb8R4/f3gZ/CX/Eqa1ZM5qT0lnDQJSddVI=;
        b=B9acNGAC3OwyKHL0pUArS2bAfO3+nGqJ4C8aQ8o82f6d8fZOJ3OYBcf3GAN6QELiXT
         vo44ZlONmZOQjwymiSLSqG/B4UX3jfnfbuh6XGtSLOilgKuCHtavlfZKQA3Wo3Nkc8Tn
         fL9r1j4lIn9amvp0IuFJUi+AmY5omGQkoLhQgfE3z112lMFiqPmN7EWsc5boJM+rGwnR
         m8hVV7rAGk8pEpnVsxVG0pF9Yves7w2ZCffOfhUV5XqN747RdnQlNYgZgWblnQWq4Bw0
         Jul5d0BK/RbrjTum8r2WYdMc+AG9Z0pYfVXpNWIhJ6+ZM8k2cRZnbMnjTmeboXVYD4IY
         W/4w==
X-Gm-Message-State: AAQBX9e22gcIotmxZNKbqJqLtPnGyGZC+QVRPWV5/hczS2ALxGerygys
        cMHMpUeue537FAQl75L96o10HT8l5vM=
X-Google-Smtp-Source: AKy350b4gVTrT0jdEJyTAOLAle1O9HpAQ2FZJ2O2eMbVOAtJVpzK7840rFjgpPtYWntiYEt7eg6fFg==
X-Received: by 2002:a17:90b:3904:b0:246:ee10:cb5d with SMTP id ob4-20020a17090b390400b00246ee10cb5dmr1795004pjb.14.1681998547069;
        Thu, 20 Apr 2023 06:49:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090a598500b00247a2498075sm1188313pji.48.2023.04.20.06.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 06:49:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dff23f7b-86a4-6984-5ce0-70aa6dbfad8e@roeck-us.net>
Date:   Thu, 20 Apr 2023 06:49:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] usb: typec: tcpm: fix multiple times discover svids
 error
To:     Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Frank Wang <frank.wang@rock-chips.com>, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230316081149.24519-1-frank.wang@rock-chips.com>
 <ZBROkdOFAP4GPPU6@kuha.fi.intel.com> <ZEDzGydXbbpekeaB@kroah.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZEDzGydXbbpekeaB@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 01:08, Greg KH wrote:
> On Fri, Mar 17, 2023 at 01:27:13PM +0200, Heikki Krogerus wrote:
>> On Thu, Mar 16, 2023 at 04:11:49PM +0800, Frank Wang wrote:
>>> PD3.0 Spec 6.4.4.3.2 say that only Responder supports 12 or more SVIDs,
>>> the Discover SVIDs Command Shall be executed multiple times until a
>>> Discover SVIDs VDO is returned ending either with a SVID value of
>>> 0x0000 in the last part of the last VDO or with a VDO containing two
>>> SVIDs with values of 0x0000.
>>>
>>> In the current implementation, if the last VDO does not find that the
>>> Discover SVIDs Command would be executed multiple times even if the
>>> Responder SVIDs are less than 12, and we found some odd dockers just
>>> meet this case. So fix it.
>>>
>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>> ---
>>>   drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>>> index 66de02a56f512..a3ae2c79f3540 100644
>>> --- a/drivers/usb/typec/tcpm/tcpm.c
>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>>> @@ -1515,7 +1515,21 @@ static bool svdm_consume_svids(struct tcpm_port *port, const u32 *p, int cnt)
>>>   		pmdata->svids[pmdata->nsvids++] = svid;
>>>   		tcpm_log(port, "SVID %d: 0x%x", pmdata->nsvids, svid);
>>>   	}
>>> -	return true;
>>> +
>>> +	/*
>>> +	 * PD3.0 Spec 6.4.4.3.2: The SVIDs are returned 2 per VDO (see Table
>>> +	 * 6-43), and can be returned maximum 6 VDOs per response (see Figure
>>> +	 * 6-19). If the Respondersupports 12 or more SVID then the Discover
>>> +	 * SVIDs Command Shall be executed multiple times until a Discover
>>> +	 * SVIDs VDO is returned ending either with a SVID value of 0x0000 in
>>> +	 * the last part of the last VDO or with a VDO containing two SVIDs
>>> +	 * with values of 0x0000.
>>> +	 *
>>> +	 * However, some odd dockers support SVIDs less than 12 but without
>>> +	 * 0x0000 in the last VDO, so we need to break the Discover SVIDs
>>> +	 * request and return false here.
>>> +	 */
>>> +	return cnt == 7;
>>>   abort:
>>>   	tcpm_log(port, "SVID_DISCOVERY_MAX(%d) too low!", SVID_DISCOVERY_MAX);
>>>   	return false;
>>
>> This is OK by men, but let's wait for Guenter.
> 
> What ever happened to this patch?
> 

It got lost in space.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

