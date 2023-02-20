Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514D269C648
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjBTIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBTIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:08:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8FC675
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:08:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 686F660CF2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE65C433EF;
        Mon, 20 Feb 2023 08:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676880487;
        bh=mAkRFlKPeHCUerommxb7CQ/VP+5UtqEsm2G6Fd1DH+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVeEXmwQNp5X/IlQWSgfIwia4Ywwi084+80ZNExpN8emciC88kkWYcrLtEgNRNVzN
         ruNF2kgzLUgGLzaghyDuWfPqEKOqrHIYMI+WDv8V3O1KBA6vGq+CBYjQWjO+keTy7A
         EOzmxzc/Fl8FV8BS3MJWS8eLWOp2is3/x7QInOX7US/eRtH/ZaY7GFYzlca3/u2/Ka
         W2IC//5bV+IrmOs7opcg3DUt9ygQnLcdpmSDzxuDdLfBDnnIEihIC5cG8jxY69bLGk
         ErqlDbMQ+69LehJvhsVwaUQ1H1wm5zfvbNf+L3cWUVNSdWOC+lyWF6F2fbq2PG7PhL
         oEbGjwK0f2teg==
Received: by pali.im (Postfix)
        id DA49E9D5; Mon, 20 Feb 2023 09:08:04 +0100 (CET)
Date:   Mon, 20 Feb 2023 09:08:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] powerpc/boot: Don't always pass -mcpu=powerpc when
 building 32-bit uImage
Message-ID: <20230220080804.vgtgx7d7qdta4r6v@pali>
References: <e3cb2642-20e4-6c26-104d-329a04260946@csgroup.eu>
 <c8d657db-02da-7840-5b40-755e47277a2c@csgroup.eu>
 <20220828174135.rcql4uiunqbnn5gh@pali>
 <d49c5905-ff68-00e9-ddaf-d60d5e5ebe65@csgroup.eu>
 <20221208191602.diywrt3g2f6zmt4s@pali>
 <aca70dc9-2185-9def-7bc0-b415bec8a5c6@csgroup.eu>
 <20221224174452.xxlkmos7yoy3qn42@pali>
 <20230122111931.hgcsc72fk6alrmzu@pali>
 <da635f99-ce3f-18e8-cf7d-7fd5923c8451@csgroup.eu>
 <c4d5cb6c-bf8f-fbc1-78ca-475f9578c551@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4d5cb6c-bf8f-fbc1-78ca-475f9578c551@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2023 08:28:18 Christophe Leroy wrote:
> Le 25/01/2023 à 08:40, Christophe Leroy a écrit :
> > 
> > 
> > Le 22/01/2023 à 12:19, Pali Rohár a écrit :
> > > On Saturday 24 December 2022 18:44:52 Pali Rohár wrote:
> > > > On Thursday 08 December 2022 19:57:39 Christophe Leroy wrote:
> > > > > Le 08/12/2022 à 20:16, Pali Rohár a écrit :
> > > > > > 
> > > > > > With "[PATCH v1] powerpc/64: Set default CPU in Kconfig" patch from
> > > > > > https://lore.kernel.org/linuxppc-dev/3fd60c2d8a28668a42b766b18362a526ef47e757.1670420281.git.christophe.leroy@csgroup.eu/
> > > > > > this change does not throw above compile error anymore.
> > > > > 
> > > > > 
> > > > > That patch should land in powerpc/next soon. When it has landed, could
> > > > > you resent this patch so that snowpatch checks the build again ?
> > > > 
> > > > Yes. But I'm still waiting because patch is not in powerpc/next yet.
> > > 
> > > Seems that it still has not landed. Any suggestions to move forward?
> > 
> > Hi
> > 
> > I just reposted to see if it passed the CI tests this time.
> 
> It is now in the tree.
> 
> Christophe

I see, thanks!
