Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFCA6284A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiKNQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiKNQHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:07:09 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9C233AE;
        Mon, 14 Nov 2022 08:07:05 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 91A335C2590;
        Mon, 14 Nov 2022 16:06:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 16F145C27B9;
        Mon, 14 Nov 2022 16:06:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668442019; a=rsa-sha256;
        cv=none;
        b=s1yZvtVPW/gIoEQWzBNkaEHDiT08UF6gI5LgF9hpRCR9MkSFwosG5P0iZBWIglerPaDvO9
        1FNlF3+enoYmfkuOGR/GGqkABjq6F69Ldwxy8JNPJ2Fx2HcjkaeZX4nMcsqPzCn7KwAOmQ
        XjgXyLPng9Wa0qMnoWildK3Hv+RAmHUXWXfb0CUDa1ijdolfdWiezkbDShwBcpT69+6vm1
        YW3vXg4uZLveStDkb5/P45N3/9z+B85QvY+9rfvS9ypBk1J+sFB3otoVc5D+fGDhfMUiSf
        5EoYqmB0zwLqPQm1BbhBVTaTVFt+8V0eGG3V8rAigfAxm1RI3pAhYFanuRArCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668442019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=jlRQp2sBofyNE5/aWx3Rzbioe7sWD5hZgsnEii6QZ3s=;
        b=Sn9/kYntar7B35rzYVuu1R85uZZmyK3x6mZmmKTvKHu5qxLlvD4kTKlIy6xPlZlLdsLQbR
        tVdNErPrJqDNX2r24EUhPpj+Mp31R00FLBPTDTEGNnQZu/3zKPQBq89wvkxasZceotZ1A+
        vgt8AK+Ngg61T2rCTE7E0GklMQ01as4NGUAith8EWNBxB4nlGQuk1P+Kist/Grd9Eyg+LV
        zjF7AaWLKxKxYeoxNJYZsAnFW2fQLkdnTK9wfxtsGQLCM450IdG3FLP9M7SF8f8uIR34+D
        p6DEBIO6b7Ppaa0iB/0MBBwdvVacUqL4xprSXVUlZ/yw6buGOKledfc3QVMnaw==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-84scr;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Exultant-Ski: 516d52175caaac81_1668442019385_3972363587
X-MC-Loop-Signature: 1668442019385:3251711514
X-MC-Ingress-Time: 1668442019384
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.74.26 (trex/6.7.1);
        Mon, 14 Nov 2022 16:06:59 +0000
Received: from rhino (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4N9vMQ2Jhxz2m;
        Mon, 14 Nov 2022 08:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668442018;
        bh=jlRQp2sBofyNE5/aWx3Rzbioe7sWD5hZgsnEii6QZ3s=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ZDS4Gh4S+zFT+j7sgoMjdxr3RKzhHJju14gFdpcMXnu0+7C8T3eG9YQy2ROfY+68D
         WzY5Oj4dqJnsonpdwEOfztiZI1hrImYYa+OAS/V5UeXP2lqyNbWzaXc/EiFtibQ3Tv
         mu3yq9or6rU3WKH++1ErRfyYO+AWFD9r8qOuHloemahChPxuZA+n4RFaQi42u+EP+l
         eRCFyCLhQjOSY8/TK6oX1e3pj7yVoFFcZd06p8DafUxqHySgmkEfqjn6TRcj5xRFkp
         HBZcETOdBSkA9L+JlGFV5RpdCLoWxr4b15d+74rYdjKNXEMozGWaeXt/BbwolitVE4
         Ibgo1rdBbkVpA==
Date:   Mon, 14 Nov 2022 11:06:56 -0500
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: omap4iss: correct cacheflush import
Message-ID: <Y3JnoHyGBttwc45O@rhino>
References: <20221113003347.93483-1-ian@linux.cowan.aero>
 <Y3JLenvvuRhb0xfZ@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3JLenvvuRhb0xfZ@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:06:50PM +0200, Laurent Pinchart wrote:
> Hi Ian,
> 
> Thank you for the patch.
> 
> On Sat, Nov 12, 2022 at 07:33:47PM -0500, Ian Cowan wrote:
> > Correct the import for cacheflush from the asm directory to the linux
> > directory.
> 
> Unless I'm mistaken, it looks like the header is actually not needed at
> all.

Good catch - it's not needed at all. I'll submit a patch momentarily
that removes it completely.

ian
