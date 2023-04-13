Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E677E6E1048
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDMOqB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Apr 2023 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDMOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:45:57 -0400
X-Greylist: delayed 494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 07:45:32 PDT
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5083EA5EC;
        Thu, 13 Apr 2023 07:45:31 -0700 (PDT)
Received: from r6.localdomain (82-217-174-174.cable.dynamic.v4.ziggo.nl [82.217.174.174])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 7C8A2302BB02;
        Thu, 13 Apr 2023 16:37:14 +0200 (CEST)
Received: by r6.localdomain (Postfix, from userid 1000)
        id 2A6AB34014C; Thu, 13 Apr 2023 16:37:14 +0200 (CEST)
Message-ID: <718c102205750a00b86e8d33748e9bfb3c485ee1.camel@klomp.org>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
From:   Mark Wielaard <mark@klomp.org>
To:     John Moon <quic_johmoo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Date:   Thu, 13 Apr 2023 16:37:14 +0200
In-Reply-To: <d34a6b09-8244-49e2-2d7a-eee5fd5ca5b7@quicinc.com>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
         <20230407203456.27141-2-quic_johmoo@quicinc.com>
         <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
         <2023041015-lunar-dandelion-1b4e@gregkh>
         <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
         <2023041136-donator-faceplate-5f91@gregkh>
         <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
         <2023041209-armed-overlaid-3d3d@gregkh>
         <d34a6b09-8244-49e2-2d7a-eee5fd5ca5b7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2023-04-12 at 09:37 -0700, John Moon via Libabigail wrote:
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
> Yes, understood that method would miss certain classes of breakages. I 
> was suggesting it as a way to improve the signal-to-noise ratio of the 
> tool since we don't currently have an algorithm for determining 
> breakages with 100% accuracy.

Note that you can check the exit code of libabigail's abidiff to see
whether something is an incompatible abi change or not, see:
https://sourceware.org/libabigail/manual/abidiff.html#return-values

You can also of course use suppressions to instruct abidiff to avoid
reporting changes involving certain ABI artifacts:
https://sourceware.org/libabigail/manual/libabigail-concepts.html#suppr-spec-label

Cheers,

Mark
