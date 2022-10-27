Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48BD60FF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiJ0ROt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiJ0ROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:14:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD23264A;
        Thu, 27 Oct 2022 10:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89597B826D7;
        Thu, 27 Oct 2022 17:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FCAC433C1;
        Thu, 27 Oct 2022 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666890879;
        bh=k+aoyyn+rNCjwBk+i7ZtBHKKkShng0Ez7j/+Qq6YQYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IT6ovDv1uwtX6yb/kvPj3J2SfhAfu7zp0GOPfvzVjNnXMf82mYZSGQIieEtdZFX8s
         WQq709mp1gPK/zjrJn6i0GO3dbrqX8eRwtzgcGjqtKnwMjSmoxM+f1WxobcuKdi5++
         uyoBkRRF6NjP6/wQMq1Tcgf3YEpT+xi66m5UPwJk=
Date:   Thu, 27 Oct 2022 19:13:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
Message-ID: <Y1q8SzpcdWgm/fLq@kroah.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-5-casey@schaufler-ca.com>
 <Y1jNGMKfb+NUPrJS@kroah.com>
 <e3949b66-26fe-807e-a626-79ca78396e8a@schaufler-ca.com>
 <Y1olXIbTGx9NnthU@kroah.com>
 <d545ef2a-5cc5-2848-e699-ff791d34d7c7@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d545ef2a-5cc5-2848-e699-ff791d34d7c7@schaufler-ca.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:08:23AM -0700, Casey Schaufler wrote:
> On 10/26/2022 11:29 PM, Greg KH wrote:
> > On Wed, Oct 26, 2022 at 05:38:21PM -0700, Casey Schaufler wrote:
> >> On 10/25/2022 11:00 PM, Greg KH wrote:
> >>> On Tue, Oct 25, 2022 at 11:45:15AM -0700, Casey Schaufler wrote:
> >>>> As LSMs are registered add their lsm_id pointers to a table.
> >>>> This will be used later for attribute reporting.
> >>>>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> ---
> >>>>  include/linux/security.h | 17 +++++++++++++++++
> >>>>  security/security.c      | 18 ++++++++++++++++++
> >>>>  2 files changed, 35 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/security.h b/include/linux/security.h
> >>>> index ca1b7109c0db..e1678594d983 100644
> >>>> --- a/include/linux/security.h
> >>>> +++ b/include/linux/security.h
> >>>> @@ -138,6 +138,23 @@ enum lockdown_reason {
> >>>>  
> >>>>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> >>>>  
> >>>> +#define LSMID_ENTRIES ( \
> >>>> +	1 + /* capabilities */ \
> >>> No #define for capabilities?
> >> Nope. There isn't one. CONFIG_SECURITY takes care of it.
> >>
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> >>>> +	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
> >>>> +
> >>>> +extern int lsm_id;
> >>> u64?
> >> u32. I doubt we'll get more than 32K security modules.
> > These should be bits, not values, right?
> 
> lsm_id is the count of security modules that are registered.
> It seemed like a good name for the value at the time, but as
> it's causing confusion I should probably change it.

Yeah, that's confusing.  "lsm_num_availble" might be better.

> > Wait, this magic entry value is going to change depeneding on what is,
> > or is not, enabled.  How is that a stable user/kernel api at all?
> >
> > confused.
> 
> I'll clarify.
> 
> This patch isn't implementing an API, but is required by subsequent
> patches that do. Does linux-api want to see patches that are in support
> of APIs, or just those with actual API implementation?

There's nothing wrong with seeing this patch, I was just confused as it
seemed to be a user facing api.  It wasn't obvious to me, sorry.

greg k-h
