Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E95B82AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiINIO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiINIOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:14:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634D4F195
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:14:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DC9615CD31;
        Wed, 14 Sep 2022 08:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663143260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iO6agN4uJI514eM1G/wjTDz2MnPOI/c/o/Iz1bdZMrY=;
        b=ZvVlxtefW6hm9QTWjPn5sqpIS0a+KfFxjnbKt7darGrJho6mcX9iANcb6oP1duft//efT+
        GRSxYHW4ATzfJiW+pTE4McIlQmL+/YeaDJ2W50sTBkbsKv36J1bYV0zEEruCDvZeFZF4nq
        ncF0oxHLSiCSA2amtoCEWFaKOCu/LPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663143260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iO6agN4uJI514eM1G/wjTDz2MnPOI/c/o/Iz1bdZMrY=;
        b=C5pNVGVeuwPKHLxwBZyns2UlX3KgfCH36tDBzNn8owFKC2PNsJps4J2dmxd626C/sDC5Qy
        CvXYGoMUl1GgzUAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B25BE2C141;
        Wed, 14 Sep 2022 08:14:20 +0000 (UTC)
Date:   Wed, 14 Sep 2022 10:14:19 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Lee@kitsune.suse.cz,
        Chun-Yi <jlee@suse.com>
Subject: Re: [PATCH] powerpc/pseries: add lparctl driver for
 platform-specific functions
Message-ID: <20220914081419.GE28810@kitsune.suse.cz>
References: <20220730000458.130938-1-nathanl@linux.ibm.com>
 <0ead0cd1-f6f6-ecf0-65d9-f3d9366e258c@linux.ibm.com>
 <87k07dl1f6.fsf@linux.ibm.com>
 <20220913091302.GY28810@kitsune.suse.cz>
 <87v8prtgcj.fsf@linux.ibm.com>
 <20220913163343.GA28810@kitsune.suse.cz>
 <87sfkvtdfx.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfkvtdfx.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:02:42PM -0500, Nathan Lynch wrote:
> Michal Such�nek <msuchanek@suse.de> writes:
> > On Tue, Sep 13, 2022 at 10:59:56AM -0500, Nathan Lynch wrote:
> >> Michal Such�nek <msuchanek@suse.de> writes:
> >> 
> >> > On Fri, Aug 12, 2022 at 02:14:21PM -0500, Nathan Lynch wrote:
> >> >> Laurent Dufour <ldufour@linux.ibm.com> writes:
> >> >> > Le 30/07/2022 � 02:04, Nathan Lynch a �crit�:
> >> >> >> +static long lparctl_get_sysparm(struct lparctl_get_system_parameter __user *argp)
> >> >> >> +{
> >> >> >> +	struct lparctl_get_system_parameter *gsp;
> >> >> >> +	long ret;
> >> >> >> +	int fwrc;
> >> >> >> +
> >> >> >> +	/*
> >> >> >> +	 * Special case to allow user space to probe the command.
> >> >> >> +	 */
> >> >> >> +	if (argp == NULL)
> >> >> >> +		return 0;
> >> >> >> +
> >> >> >> +	gsp = memdup_user(argp, sizeof(*gsp));
> >> >> >> +	if (IS_ERR(gsp)) {
> >> >> >> +		ret = PTR_ERR(gsp);
> >> >> >> +		goto err_return;
> >> >> >> +	}
> >> >> >> +
> >> >> >> +	ret = -EINVAL;
> >> >> >> +	if (gsp->rtas_status != 0)
> >> >> >> +		goto err_free;
> >> >> >> +
> >> >> >> +	do {
> >> >> >> +		static_assert(sizeof(gsp->data) <= sizeof(rtas_data_buf));
> >> >> >> +
> >> >> >> +		spin_lock(&rtas_data_buf_lock);
> >> >> >> +		memset(rtas_data_buf, 0, sizeof(rtas_data_buf));
> >> >> >> +		memcpy(rtas_data_buf, gsp->data, sizeof(gsp->data));
> >> >> >> +		fwrc = rtas_call(rtas_token("ibm,get-system-parameter"), 3, 1,
> >> >> >> +				 NULL, gsp->token, __pa(rtas_data_buf),
> >> >> >> +				 sizeof(gsp->data));
> >> >> >> +		if (fwrc == 0)
> >> >> >> +			memcpy(gsp->data, rtas_data_buf, sizeof(gsp->data));
> >> >> >
> >> >> > May be the amount of data copied out to the user space could be
> >> >> > gsp->length. This would prevent copying 4K bytes all the time.
> >> >> >
> >> >> > In a more general way, the size of the RTAS buffer is quite big, and I'm
> >> >> > wondering if all the data need to be copied back and forth to the kernel.
> >> >> >
> >> >> > Unless there are a high frequency of calls this doesn't make sense, and
> >> >> > keeping the code simple might be the best way. Otherwise limiting the bytes
> >> >> > copied could help a bit.
> >> >> 
> >> >> This is not intended to be a high-bandwidth interface and I don't think
> >> >> there's much of a performance concern here, so I'd rather just keep the
> >> >> copy sizes involved constant.
> >> >
> >> > But that's absolutely horrible!
> >> 
> >> ?
> >> 
> >> > The user wants the VPD data, all of it. And you only give one page with
> >> > this interface.
> >> 
> >> The code here is for system parameters, which have a known maximum size,
> >> unlike VPD. There's no code for VPD retrieval in this patch.
> >
> > But we do need to support the calls that return multiple pages of data.
> >
> > If the new driver supports only the simple calls it's a failure.
> 
> Michal, will you please moderate your tone? I think you can communicate
> your concerns without calling my work "absolutely horrible" or a
> "failure". Thanks.

Sorry, it's not a good wording.

> Anyway, of course I intend to support the more complex calls, but
> supporting the simple calls actually unbreaks a lot of stuff.

The thing is that supporting calls that return more than one page of
data is absolutely required, and this interface built around fixed size
data transfer can't do it.

So it sounds like a ticked for redoing the driver right after it's
implemented, or ending up with two subtly different interfaces - one for
the calls that can return multiple pages of data, and one for the simple
calls.

That does not sound like a good idea at all to me.

> 
> >> But I'm happy to constructively discuss how a VPD ioctl interface should
> >> work.
> >> 
> >> > Worse, the call is not reentrant so you need to lock against other users
> >> > calling the call while the current caller is retrieving the inidividual
> >> > pagaes.
> >> >
> >> > You could do that per process, but then processes with userspace
> >> > threading would want the data as well so you would have to save the
> >> > arguments of the last call, and compare to arguments of any subsequent
> >> > call to determine if you can let it pass or block.
> >> >
> >> > And when you do all that there will be a process that retrieves a couple
> >> > of pages and goes out for lunch or loses interest completely, blocking
> >> > out everyone from accessing the interface at all.
> >> 
> >> Right, the ibm,get-vpd RTAS function is tricky to expose to user space.
> >> 
> >> It needs to be called repeatedly until all data has been returned, 4KB
> >> at a time.
> >> 
> >> Only one ibm,get-vpd sequence can be in progress at any time. If an
> >> ibm,get-vpd sequence is begun while another sequence is already
> >> outstanding, the first one is invalidated -- I would guess -1 or some
> >> other error is returned on its next call.
> >> 
> >> So a new system-call level interface for VPD retrieval probably should
> >> not expose the repeating sequence-based nature of the RTAS function to
> >> user space, to prevent concurrent clients from interfering with each
> >> other. That implies that the kernel should buffer the VPD results
> >> internally; at least that's the only idea I've had so far. Open to
> >> other suggestions.
> >
> > It can save the data to an user-supplied buffer until all data is
> > transferred or the buffer space runs out.
> 
> Yes, of course, thanks. Assuming user space can discover the appropriate
> buffer size, which should be possible.

It will not be entirely reliable because the data size may change over
time but assuming the performance is not an issue the caller can just
call again with a bigger buffer if the data hapens to grow at the very
moment they tried to retrieve it.

Thanks

Michal
