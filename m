Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC9B638E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKYQTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKYQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:19:10 -0500
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947E4D5DE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:19:07 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NJg6J6b62zMqP72;
        Fri, 25 Nov 2022 17:19:04 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NJg6G2txNzMppfG;
        Fri, 25 Nov 2022 17:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1669393144;
        bh=8KIw3cJWuenjkvUEMm336PVQdkbi37jR7q+oe3VSuIc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BFhys6FYtGUBFxFuZflPQiWKF+fY90xkLigE0RtoO7b2ML8qXAhc6o8LWTTs8jcir
         FZm+pczKZCXoiempppTAvfp6XD470ybZL+aYe4DHXfjfLW7rdm0G8OgjCC8xI0wysp
         2PK1iUxNe2dUnzO7sXhraK9mLWL6MlwpDEbMMucY=
Message-ID: <463cb747-5bac-9e8e-b78e-1ff6a1b29142@digikod.net>
Date:   Fri, 25 Nov 2022 17:19:01 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
References: <20221123201552.7865-1-casey@schaufler-ca.com>
 <20221123201552.7865-2-casey@schaufler-ca.com> <Y38D1s3uQ6zNORei@kroah.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Y38D1s3uQ6zNORei@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/11/2022 06:40, Greg KH wrote:
> On Wed, Nov 23, 2022 at 12:15:44PM -0800, Casey Schaufler wrote:
>> Create a struct lsm_id to contain identifying information
>> about Linux Security Modules (LSMs). At inception this contains
>> the name of the module and an identifier associated with the
>> security module. Change the security_add_hooks() interface to
>> use this structure. Change the individual modules to maintain
>> their own struct lsm_id and pass it to security_add_hooks().
>>
>> The values are for LSM identifiers are defined in a new UAPI
>> header file linux/lsm.h. Each existing LSM has been updated to
>> include it's LSMID in the lsm_id.
>>
>> The LSM ID values are sequential, with the oldest module
>> LSM_ID_CAPABILITY being the lowest value and the existing modules
>> numbered in the order they were included in the main line kernel.
>> This is an arbitrary convention for assigning the values, but
>> none better presents itself. The value 0 is defined as being invalid.
>> The values 1-99 are reserved for any special case uses which may
>> arise in the future.
> 
> What would be a "special case" that deserves a lower number?

I don't see any meaningful use case for these reserved numbers either. 
If there are some, let's put them now, otherwise we should start with 1. 
Is it inspired by an existing UAPI?
Reserving 0 as invalid is good though.
