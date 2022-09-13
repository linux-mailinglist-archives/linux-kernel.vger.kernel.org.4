Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD15B6A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiIMJNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiIMJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:13:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D575C9DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:13:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D1F9A34A18;
        Tue, 13 Sep 2022 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663060383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTiIlBHoVD7IWZRPsxIBM3SlLA1vpYBW2BaQqciHKbo=;
        b=cUm7/hKrDN8DLP7DMBIegJFCdjmzlB6BKsToVyujxMJ1IeO1EG7KQYcAzMM0al/kczKeyK
        um6OVTq7qhtjI7B+Bo1/7op4SIxMWfaL5CCexlnwKWJd/RHJZIPucImvbTx2PJgNTXcyUd
        rvHWIg95sHxxNHk9cm5Qg7bTYgTbT2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663060383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTiIlBHoVD7IWZRPsxIBM3SlLA1vpYBW2BaQqciHKbo=;
        b=rmeK5EVO+cR1vv98ttiOwwlCc08Cr/iTFv2Mph8HE/XGSAzdjVEDfGiTCN6ndtIJaoNML7
        M15kSyxd0z0yF2BA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5E1172C143;
        Tue, 13 Sep 2022 09:13:03 +0000 (UTC)
Date:   Tue, 13 Sep 2022 11:13:02 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Lee@kitsune.suse.cz,
        Chun-Yi <jlee@suse.com>
Subject: Re: [PATCH] powerpc/pseries: add lparctl driver for
 platform-specific functions
Message-ID: <20220913091302.GY28810@kitsune.suse.cz>
References: <20220730000458.130938-1-nathanl@linux.ibm.com>
 <0ead0cd1-f6f6-ecf0-65d9-f3d9366e258c@linux.ibm.com>
 <87k07dl1f6.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k07dl1f6.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:14:21PM -0500, Nathan Lynch wrote:
> Laurent Dufour <ldufour@linux.ibm.com> writes:
> > Le 30/07/2022 à 02:04, Nathan Lynch a écrit :
> >> +static long lparctl_get_sysparm(struct lparctl_get_system_parameter __user *argp)
> >> +{
> >> +	struct lparctl_get_system_parameter *gsp;
> >> +	long ret;
> >> +	int fwrc;
> >> +
> >> +	/*
> >> +	 * Special case to allow user space to probe the command.
> >> +	 */
> >> +	if (argp == NULL)
> >> +		return 0;
> >> +
> >> +	gsp = memdup_user(argp, sizeof(*gsp));
> >> +	if (IS_ERR(gsp)) {
> >> +		ret = PTR_ERR(gsp);
> >> +		goto err_return;
> >> +	}
> >> +
> >> +	ret = -EINVAL;
> >> +	if (gsp->rtas_status != 0)
> >> +		goto err_free;
> >> +
> >> +	do {
> >> +		static_assert(sizeof(gsp->data) <= sizeof(rtas_data_buf));
> >> +
> >> +		spin_lock(&rtas_data_buf_lock);
> >> +		memset(rtas_data_buf, 0, sizeof(rtas_data_buf));
> >> +		memcpy(rtas_data_buf, gsp->data, sizeof(gsp->data));
> >> +		fwrc = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
> >> +				 NULL, gsp->token, __pa(rtas_data_buf),
> >> +				 sizeof(gsp->data));
> >> +		if (fwrc == 0)
> >> +			memcpy(gsp->data, rtas_data_buf, sizeof(gsp->data));
> >
> > May be the amount of data copied out to the user space could be
> > gsp->length. This would prevent copying 4K bytes all the time.
> >
> > In a more general way, the size of the RTAS buffer is quite big, and I'm
> > wondering if all the data need to be copied back and forth to the kernel.
> >
> > Unless there are a high frequency of calls this doesn't make sense, and
> > keeping the code simple might be the best way. Otherwise limiting the bytes
> > copied could help a bit.
> 
> This is not intended to be a high-bandwidth interface and I don't think
> there's much of a performance concern here, so I'd rather just keep the
> copy sizes involved constant.

But that's absolutely horrible!

The user wants the VPD data, all of it. And you only give one page with
this interface.

Worse, the call is not reentrant so you need to lock against other users
calling the call while the current caller is retrieving the inidividual
pagaes.

You could do that per process, but then processes with userspace
threading would want the data as well so you would have to save the
arguments of the last call, and compare to arguments of any subsequent
call to determine if you can let it pass or block.

And when you do all that there will be a process that retrieves a couple
of pages and goes out for lunch or loses interest completely, blocking
out everyone from accessing the interface at all.

Thanks

Michal
