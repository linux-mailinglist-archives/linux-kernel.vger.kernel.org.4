Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD329621A4D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiKHRVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiKHRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:21:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA9E1C;
        Tue,  8 Nov 2022 09:21:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E482B81BE0;
        Tue,  8 Nov 2022 17:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33235C433C1;
        Tue,  8 Nov 2022 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667928070;
        bh=DlMHpgYF6fEe5J2HjZk1J+WbnRi5LdPQe3AxBSfoBtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6Cv5V6efM2n7JUbiYlknPcXf5YU+wsfF3ayVGOcCl6KzWjTQfpf9P/DxPBzki7xQ
         w0H4anKjaubXltO/ORS0AxYyYWMUW02TpkK0lxtNWvEuNTJgxy5kI1HkytTAI3BRMZ
         qAvnl6sZ56oXhnSc4GjGnL/EEuXmow5ZOmOh+AHCZcmB259ApGTdpLZJ1ZOS6P+ivR
         pmlVeEFZZ3yQ8sIs02fhYwk5S6jOPy7jynVJbJcbOWbsadqc7XwcQoVD+0PiJOCjQG
         C/CHCiih+Zy1HlFxwbn2gTA8HRZ2JKgNK6TfgHh2wnDl3aFbqqm+2mzG/YhPqBx/sv
         mau3HKmmFbgJw==
Date:   Tue, 8 Nov 2022 17:21:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Shan <gshan@redhat.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/5] cacheinfo: Use riscv's init_cache_level() as generic
 OF implem
Message-ID: <Y2qQABd9Xsubx77Q@spud>
References: <20221108110424.166896-1-pierre.gondois@arm.com>
 <20221108110424.166896-2-pierre.gondois@arm.com>
 <Y2pirStbsJOidAkz@wendy>
 <20221108155906.3pssiipdfrm55q56@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108155906.3pssiipdfrm55q56@bogus>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 03:59:06PM +0000, Sudeep Holla wrote:
> On Tue, Nov 08, 2022 at 02:07:41PM +0000, Conor Dooley wrote:
> > On Tue, Nov 08, 2022 at 12:04:17PM +0100, Pierre Gondois wrote:
> > > Riscv's implementation of init_of_cache_level() is following
> > 
> > heh, "Riscv" always looks a bit odd!
> > Code movement looks fine, nothing surface level is broken on RISC-V.
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >
> Thanks for the review and testing. I was planning to ask Pierre to cc you
> next time but you seem to have covered that for me :).

Ye no worries.
Feel free to add some sort of "R: Conor Dooley <conor@kernel.org>" entry
where appropriate if you want to make sure I'll take a look - but I
should see it anyway if it goes to the riscv list.
Up to you.

