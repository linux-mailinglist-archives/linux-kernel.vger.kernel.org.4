Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEC8630F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 15:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiKSOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 09:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiKSOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 09:38:30 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF7101B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 06:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668868695; bh=Jz7M9F/3eqEBLfPBjUS9+XrP/DelKWgpIU8laThZDGs=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=EIoJKtgv5FraUj3Z5PFu8Jok9KdTYUAtXWoaLISjiFZqiuOlmXfrqqDDxlYQYX0DW
         mqrViu2Avs0/Yn57PbOApEehr/wEJ7/+rn1kiz/TEVa1XGTMWcKxMldaKc8BtXGX/D
         hfBumq2JdhRwnMcRxtUQZpH66x5qor9tW+j7KriU=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat, 19 Nov 2022 15:38:15 +0100 (CET)
X-EA-Auth: mmkQZ8VI3MNf0jDBC/4PS39FR9rlgSCuB7sNl819sERniGenzDBR5T/RHVGDbxTtDjLG5q1mHLp5P5VjVc35PZZC56/w7DTR
Date:   Sat, 19 Nov 2022 20:08:10 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gustavoars@kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <Y3jqUpNOygJ4+2jy@qemulion>
References: <Y3YKhee8L+kAfHM4@qemulion>
 <Y3YvGdkyGm7azGg4@kroah.com>
 <Y3Y1N6AwWEXLpSrx@qemulion>
 <Y3Z3aatcaISvqURJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Z3aatcaISvqURJ@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:03:21PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 17, 2022 at 06:50:55PM +0530, Deepak R Varma wrote:
> > On Thu, Nov 17, 2022 at 01:54:49PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Nov 17, 2022 at 03:48:45PM +0530, Deepak R Varma wrote:
> > > >
> > > >  struct hfa384x_pdr_refdac_measurements {
> > > > -	u16 value[0];
> > > > +	DECLARE_FLEX_ARRAY(u16, value);
> > > >  } __packed;
> > >
> > > Why?  This structure is never used anywhere, right?  So why is this
> > > needed to be changed and not just removed entirely?  Same for the other
> > > structures in this patch.
> >
> > Hello Greg,
> > I am unable to confirm that these structures are truly not needed in the absence
> > if a real device based testing. I could only validate that using the compile
> > build and driver loading.
>
> Think this through, if no one is actually using this structure, and it
> is of 0 size, then do you think it is being used?

Hello Greg,
I did not find any memory allocation for these zero length array structures.
Also, the union or its enclosing structure do not appear to access the members.
Hence I am leaning towards concluding that these zero length array structures do
not appear to be necessary.

There are a few other structures that are part of the same union, however, they
too do not appear to be used for accessing the memory assigned to the union [or
its enclosing structure]. I think most of the members of these unions can be
replaced by one max size structure of this union [e.g. struct
hfa384x_pdr_mkk_measurements].

Could you please comment if I am reading the code right?

For your quick reference, the zero length structure declaration are online 963
whereas the union is on line number 1080 of the file drivers/staging/wlan-ng/hfa384x.h


Thank you,
./drv


>
> > This change that I am proposing in the interim would enable the compiler to
> > protect the structure from addition of a new member below the zero length array.
>
> Why would you want to add a new member below this?  That's not what is
> happening here at all.

I came across this one old commit where such an accident happened. This is from
a recent LWN article:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e48f129c2f20

I understand the C99 now protects from such an attempt at the compile time
itself.

Thank you,
./drv


>
> Please think this through a bit more.
>
> good luck!
>
> greg k-h
>


