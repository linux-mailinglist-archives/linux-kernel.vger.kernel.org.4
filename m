Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC8749B35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjGFLz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjGFLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639C1732
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:55:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D50D56190D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E3EC433C8;
        Thu,  6 Jul 2023 11:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688644554;
        bh=BGc/sGoxt46gvCplYYAp6lrh85oEpbkPlYP/t1UMvII=;
        h=Date:From:To:Cc:Subject:From;
        b=QHrNdqEM7O7UaM9Hk0wAgbbc/0OawSLtVVbHCo+lW91jkW1ivv4ee1wXy5+0HtN5A
         n0sVLHzoatVIGGHWurEnBQrLdDH1OJ6YYZw+/i2Gwhlp/Mu9z3j2WHmbMfNu1RKWa6
         fv7bMTWyGavPKaqRyDgU1e9eEf+W8FiVBK5os63ADlB+33bJjcjeAzD2VjaHTQ6pQS
         asw4acuYkQ3QimKA3jf1ErLHsaVCTXcwu+w/amckpAoR9nfQHnn6drE0+5TPUnaFyZ
         YA4Yq1Dhjg2+lJAHyI5D+lvoPWkTpFlxAvovuxcug3zmidY7st7IcomGoNFpxqAYDj
         CQt6pNNmNLIcg==
Received: by pali.im (Postfix)
        id CB6A7970; Thu,  6 Jul 2023 13:55:50 +0200 (CEST)
Date:   Thu, 6 Jul 2023 13:55:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: binfmt_misc & different PE binaries
Message-ID: <20230706115550.sqyh3k26e2glz2lu@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to ask how to properly register binfmt_misc for different
PE binaries, so kernel could execute the correct loader for them.

I mean, how to register support for Win32 (console/gui) PE binaries and
also for CLR PE binaries (dotnet). Win32 needs to be executed under wine
and CLR ideally under dotnet core (or mono).

I have read kernel documentation files admin-guide/binfmt-misc.rst
and admin-guide/mono.rst. But seems that they are in conflicts as both
wants to registers its own handler for the same magic:

  echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register

  echo ':CLR:M::MZ::/usr/bin/mono:' > /proc/sys/fs/binfmt_misc/register

Not mentioning the fact that they register DOS MZ handler, which matches
not only all PE binaries (including EFI, libraries, other processors),
but also all kind of other NE/LE/LX binaries and different DOS extenders.

From documentation it looks like that even registering PE binaries is
impossible by binfmt_misc as PE is detected by checking that indirect
reference from 0x3C is PE\0\0. And distinguish between Win32 and CLR
needs to parse PE COM descriptor directory.

Or it is possible to write binfmt_misc pattern match based on indirect
offset?
