Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C473977B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjFVGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVGbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:31:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB5FC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A63261772
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 06:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D074C433C8;
        Thu, 22 Jun 2023 06:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687415509;
        bh=8I3kJ3yOV1l9VHYXSTomQCnY9vroIhrMd3w0kNO1mok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4admOdfTJlntgfqiYhEbR+hYmU1RQkqVn3vkCG8qxpgca6Vu3XNiT2wZaSMSJ8jc
         im7uujX9ssnfnP/0KagDOeLDuQmYKE/fcaVBCzVifC21TMCT4mdjp1CPA7oAwlscn9
         0pmlZ8AZtu9DNJfaKHdyesgXuhkLkL6Ck4NVzYs+o5KfZVkp+RnJzr2OJYvAF9zrZ6
         dlFkIdUEtlsuE1BfNHC9GavOTCKpnGTJxzhmS20EsBGyI1TyArcdPLTOwdJz373DV3
         6TwWzxM2DEP6aXcBJUb7t/SWbAhWAhuA3MaZ33f6497ZobQKof4mmspk7ODUkw0vyd
         JOA5z/W9a5kbw==
Date:   Wed, 21 Jun 2023 23:31:47 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] objtool: Make 'sec-address' always on
Message-ID: <20230622063147.wpd4nxvludjjk2qa@treble>
References: <e7e1de1d01194df3ff4053cb0815fc2ddba33213.1687360711.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7e1de1d01194df3ff4053cb0815fc2ddba33213.1687360711.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 05:20:31PM +0200, Christophe Leroy wrote:
> Most of the time objtool warnings are useless without the
> absolute address within the section.
> 
> Today there is --sec-address option to get it printed, but
> that option is nowhere used and requires a change in Makefile
> to use it.
> 
> Having the address inside the section at all time in addition
> to the address within the object doesn't hurt and will help.
> 
> Remove the --sec-address option and print it at all time.

This option actually feels like clutter to me.  The func+offset format
works fine, combined with scripts like objdump-func and faddr2line.  And
we also have a new OBJTOOL_VERBOSE=1 option which auto-disassembles the
affected function.

On x86 we've been using func+offset for console stack traces for many
years, due to KASLR.  So maybe we're just more used to it.  But the
scripts make it fine.

Also it helps with identifying the same warning across different
configs/compilers.

-- 
Josh
