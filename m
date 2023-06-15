Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D68731BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbjFOOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbjFOOpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:45:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477832736;
        Thu, 15 Jun 2023 07:45:18 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4284445a12.2;
        Thu, 15 Jun 2023 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686840318; x=1689432318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ED/wxhW99FN+zk9GAPL31YRv7SWGPV9mFSC1g/5zgiQ=;
        b=AJ9zNQxXwhNH/yGTaTuXBdAOXQonHX5+rtfC8vBsyGyAJlw1XvnwiR6cFi/LJRfPKL
         xuGc4uw7s7ZCZc2/XHzhj+v1JezT2OAu0Drn3rl7/Nk2bpzED0pS0DOrprvGMGnRtjmP
         RJJJ8RPc4Qml2NWGW+Lcevim2b2xSTaGxWi7oqXdLz6M7tXiV8glNmdAoOQDm9JNG3/Z
         RCnk9mk2w2ZaymyjkXQe7kIyNQVNa7sbf4Yhk6ziZQhgnll4SJ0UcXfeeg5Lx66ilBly
         a6rut/JXkCWpeZKDTL9+85X42AeLgSgns/F6m/ficPgkzr7uUxIS/vqFQClAKbsNf1ti
         HVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840318; x=1689432318;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ED/wxhW99FN+zk9GAPL31YRv7SWGPV9mFSC1g/5zgiQ=;
        b=OvN8bWZ0gJ/abovLoTsuaCxW0/Y9pxpkdxe+NRZaIi+YxEtp6HNkOc5oG1x/2Jt/u0
         F9YwJnTQ75HptndpIXL2TBXd1T/9wUle0m/d/Mc1nb1QKlQg4u5aCbX3mDnHRogf87+D
         Spz1nv3hw96YSh8al8m8NVyEmGJGSdKLaS0QCfdwkEATrOpX+ioAf1d4IgIy0QmBp8kZ
         sVQrLC/4y5mvHXjB6TQoLn4nRlllN211BgtMqfwn1T2cvSkZp3DeL9ctGuuAEP17m50h
         enCMS7Mhr8WkzmgW/omrMjCoe0f0K8EnXl4eRiL7NHpez+DkWcxzXlK2oIOwSXI4AIn4
         B9DQ==
X-Gm-Message-State: AC+VfDxShhJmQe0wZyjdxKMdL/8JkWpnhKPS9yx/CvmwJZx5UcKhZBup
        Ll5h96H12WkjGZvEWIcO9llouItafZE=
X-Google-Smtp-Source: ACHHUZ74IWx1zjxNoDY8f7kfrYb9FuYOwYsIWQdJKopVXE5Bm2pkqjzKK8oB69fpZ5gk196r/MDPSg==
X-Received: by 2002:a17:90a:2ca4:b0:25b:a9f1:9dee with SMTP id n33-20020a17090a2ca400b0025ba9f19deemr3848500pjd.0.1686840317524;
        Thu, 15 Jun 2023 07:45:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a030600b0024dfb8271a4sm13928491pje.21.2023.06.15.07.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 07:45:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4594248c-b7c5-46cb-7d02-063c8235f5d2@roeck-us.net>
Date:   Thu, 15 Jun 2023 07:45:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFT] Prototype of new watchdog
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Oliver Neukum <oneukum@suse.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230615104137.20304-1-oneukum@suse.com>
 <20230615104137.20304-2-oneukum@suse.com>
 <1282253f-29a4-f6ad-8d7a-36efb02e040a@csgroup.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1282253f-29a4-f6ad-8d7a-36efb02e040a@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 07:29, Christophe Leroy wrote:
> Please explain what this driver is.
> 
> Is that a driver for a new type of pcwd_usb ?
> Is that a new driver for an existing equipment ? Why a new driver then ?
> 
> If it is an evolution of the existing driver, please do it in place of
> the existing driver so that we see what is changed and what remains.
> 

Agreed, this should be a patch modifying pcwd_usb.c to use the watchdog core.
Any cleanups should be sent as separate patches.

Thanks,
Guenter

