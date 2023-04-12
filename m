Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0596DFB93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDLQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjDLQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:43:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8665A1;
        Wed, 12 Apr 2023 09:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BC6463742;
        Wed, 12 Apr 2023 16:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE23C4339B;
        Wed, 12 Apr 2023 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681317784;
        bh=tghXf6ZJNEtwzaF6Ct8z2O+2xY38x0zbM8ak45EK8/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWsLHopw7Xr+qeJ+1ZM3O8jXOS/hjzlARh8LHzPdDwG+rLR9BrwuS67i5bgXb595o
         Zkm9JuIY3OViS+6mKEPuJkhVGdxZ5evNBBJHYkhONELH9iKazSefoTp8nAbuJNciW+
         LxCnpQVHdhrATPb5DwgdpfMTPm6sHCqKoGeDhzgw=
Date:   Wed, 12 Apr 2023 18:43:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Message-ID: <2023041216-antitoxic-finch-dd14@gregkh>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh>
 <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
 <2023041136-donator-faceplate-5f91@gregkh>
 <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
 <2023041209-armed-overlaid-3d3d@gregkh>
 <d34a6b09-8244-49e2-2d7a-eee5fd5ca5b7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34a6b09-8244-49e2-2d7a-eee5fd5ca5b7@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:37:16AM -0700, John Moon wrote:
> On 4/11/2023 11:14 PM, Greg Kroah-Hartman wrote:
> > > Would you find the tool more useful if it simply filtered out all instances
> > > where the size of the type did not change? This would filter out the
> > > following which the tool currently flags:
> > > 
> > > - enum expansions
> > > - reserved field expansions
> > > - expansions of a struct with a flex array at the end
> > > - type changes
> > > - re-ordering of existing members
> > > - ...others?
> > 
> > Obviously not, as some of those are real breakages, and some are not at
> > all.
> > 
> > Please understand what is an abi breakage.  Adding new enums is not.
> > Using a reserved field is not.  Reording existing members IS.
> > 
> 
> Yes, understood that method would miss certain classes of breakages. I was
> suggesting it as a way to improve the signal-to-noise ratio of the tool
> since we don't currently have an algorithm for determining breakages with
> 100% accuracy.

Why not?  You know the different types of things here based on the
differences between the dwarf data, and they fall into different
categories, and those different categories mean different things.

If you have questions as to which type of change is allowed and which is
not, just ask us, the rules are not complex, nor impossible to describe,
otherwise we wouldn't have a stable api at all, right?

thanks,

greg k-h
