Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7616C69D41E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjBTTfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjBTTfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:35:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B64166E2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:35:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0B5460EC9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6684AC433EF;
        Mon, 20 Feb 2023 19:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676921729;
        bh=c+NPbo+xc61pSWolom8BywTZ6muGgUXSvYoSGCgmulM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndMe5DfM2vZqNbIW2iuwymxIdKG4oA9ykkpL8poyq7bRlXn4Gm7XESG+e334Mv1wn
         9ZbI0KrIDidHEQfy1osXWOCc9z1MMhNKEWi9EILgfE/5AfWKyptJeWQb+K3BVkCr45
         vfAzh+IBHYOJdlH+juDMLDkQS6g8PgRYIcxTUxnxSmOjNaf2vOzqfl2CPQgsJL+Lfc
         ZFEgpaC9XgxwW/xW9jHEWf1ByO8I41qbnZOirxnd7A+lkA6ha1VglpI2MVH7aajiFZ
         nCZhut8il7nC+Zjy/UwfMcGtE2sIMBcsBZA0fP8JhljE6az7WAQG2aZfgg0Lh6MBaT
         mnWjtWHF/gKvg==
Date:   Mon, 20 Feb 2023 11:35:26 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?utf-8?B?Sm9zw6k=?= Oliveira <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] x86/bugs: Allow STIBP with IBRS
Message-ID: <20230220193526.if5zfd6j7sbjpf7g@treble>
References: <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble>
 <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble>
 <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble>
 <Y/O9U4KFtXE8Yoyt@zn.tnic>
 <20230220190908.gfd2c4tuzeb7cft6@treble>
 <CACYkzJ58HoDz+hpLzWf0PZQX7ykWqB6-uQR9HVb5YqaF-rdScA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACYkzJ58HoDz+hpLzWf0PZQX7ykWqB6-uQR9HVb5YqaF-rdScA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:16:45AM -0800, KP Singh wrote:
> > As far as I can tell, that document was never updated to describe
> > spectre_v2=ibrs in the first place.  That would be a whole 'nother patch
> > which I'm not volunteering for.  Nice try ;-)
> 
> This should at least be documented in the code.
> 
> Now it seems like it is not okay to work with people on the list and
> just send revisions bypassing them. This is not something we do in the
> kernel area I come from (an x86 favorite ;)).  Please feel free to go
> with Josh's version (or its future revisions). If you want me to
> re-spin with some comments, happy to. If not, please do at least give
> me Reported-by here.

It's a common practice even outside of x86.  I'd recommend not taking it
personally.  In the end it's all about what produces better code.

And please don't take this the wrong way, but sometimes it takes a bad
patch to inspire a better one.  I mean that with no disrespect, I myself
have sent many bad patches.

And if you don't like my patch, fine, send a v2...

-- 
Josh
