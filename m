Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9A6C4729
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCVKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:03:04 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E0110AA1;
        Wed, 22 Mar 2023 03:03:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 454F032001FC;
        Wed, 22 Mar 2023 06:03:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Mar 2023 06:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679479380; x=
        1679565780; bh=01BphvSHd3yOGvmiCEj40q4zB9VSZQG06l0nNVJyKc8=; b=O
        0Rr9HNXSPG0YhJe6vpGux0Bj/p3aK207o1OzFfe3ISExY2Ie8qC1M43BBYhiREDp
        5QNkGZpKeKHViH5ZG0SwWdeWAI78YgugXITjjpeSVRWJIVz1W23/eL9lmCd5+3lq
        eDkO78DWxNLzNZAZVcHoqPnwQ/1iB+NWOC3/A5gNYEyleJ4LjDMKkcS7Rt+ajyNg
        4gz0oTH6nhRyQBLCLznx+B/1IeYLPCufNUA2pFcp9GCGAqzg1lsFfkhsd4BBsZeh
        SUyOZe9kgw+S/Cljj5yvNlxi7q07Tu4fbg+AYoCRkWuTmBq+nODTPWr3EKXmwJqD
        H/INQXX3PRESsO2hbSeYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679479380; x=1679565780; bh=01BphvSHd3yOG
        vmiCEj40q4zB9VSZQG06l0nNVJyKc8=; b=VT+StNbV7vIVRrtHIUe2nD3pFRu96
        eVD3XMpG5MDhzhFHuNZv3tfx5Omgy5LQRZwGCyJp6z467HrffGFE0QbnCtIvDgXO
        uZBsSkAxD/NloWPlT0VZzKYR0VBDFsDQb9JwOrAU9Uc7Gg31Z81iCscgdDow7fvb
        rSzHPhT3ksqtPa5ipUazip27+IQIYr/TM0CI0ajdZTaeUKaMzFitJcODFPPem5qt
        gW38d8P7mMKynLUVB+dKavxb+oszHaUTrJ3iPhQHQXaLH53TVwkTyhDaVvSJZpLV
        bZDMCSdaX6fOiT/qYu7n978QF8xBvYDrOL481JO+94YlHxK1JRxbQTD9A==
X-ME-Sender: <xms:VNIaZCXC9PtCC7IKndfCUhoZ1Tn86zg0Vua4LXrzwFPzBsTS1mZ6jw>
    <xme:VNIaZOkDtoUcrlBtolMIm_fBV8qNYRhzL2qGGLmnmL31iQgM2xVmo070QlxZHvsaV
    IWxYYIExdA9EylCDF0>
X-ME-Received: <xmr:VNIaZGZYLxZfeOGZUn-VjGx3wxClqrRrBMQCp6MBXosBGEkcWkUka20A2u83G0lD-fYsqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:VNIaZJWzfzIz-QB-mJb7wS9uCFs1PQ0JeVL2LDjftU1ZxdbrW0SV8Q>
    <xmx:VNIaZMkYVzsDSkypd0kz-Y_8Qz0W6LowTJrOpJsRPL8DjqaQ3IAPkw>
    <xmx:VNIaZOe_jCzCXIzIHDTjSDJUKafdldG-fVCOs356poeXBmsUhVJHAg>
    <xmx:VNIaZGVaPHeo8dgohOOGUlxMbs9RJkGYZbHzBd1wo_8aGchL6RGSrg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 06:03:00 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9FD9310A603; Wed, 22 Mar 2023 13:02:58 +0300 (+03)
Date:   Wed, 22 Mar 2023 13:02:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: drop ranges for definition of ARCH_FORCE_MAX_ORDER
Message-ID: <20230322100258.bgqgawzpfoetqlbc@box>
References: <20230322081520.2516226-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322081520.2516226-1-rppt@kernel.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 10:15:20AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> MIPS defines insane ranges for ARCH_FORCE_MAX_ORDER allowing MAX_ORDER
> up to 63, which implies maximal contiguous allocation size of 2^63
> pages.
> 
> Drop bogus definitions of ranges for ARCH_FORCE_MAX_ORDER and leave it a
> simple integer with sensible defaults.
> 
> Users that *really* need to change the value of ARCH_FORCE_MAX_ORDER
> will be able to do so but they won't be mislead by the bogus ranges.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
