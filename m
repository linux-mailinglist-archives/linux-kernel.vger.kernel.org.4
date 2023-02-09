Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1978A6903A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjBIJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBIJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:29:03 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A985EFA8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:29:01 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l12so1655665edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iLTALZ1oNGZ62291k/DnFlVymjqqmbMKSdTxFP2GIBk=;
        b=lMuelBIsYDCyQ/RL1kGwChDTydCg2S1df4RiDZ/Eh6gJOrrz75QTjiW868FcbCsEz3
         9rCt/ROlOZmdwkwlEMj8l97RJwP+NE60y/oiUO2bAwgyeJjHi+6i//EHNpYrczriqydX
         RrRi4BzGU8MHBDVnD2b+GUe79XZNYn7sPGgD9cvL3Qg9Cwb9UoPPCkOwqtMDttQsp+nJ
         g1Q9acBy1+f1s75ZLjRuVn+V86BAiyM5t4jyggcw0OhHlI6gyOar0xUT2wwB+BXIiFB1
         o71Vm76cGHEHvlWbFBXzvptNMaEpGv0kG81Tl9KjqbZmVZUCPpcE/Wh07To6/oMoJK0b
         nVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLTALZ1oNGZ62291k/DnFlVymjqqmbMKSdTxFP2GIBk=;
        b=5akglQA+Azkaj0+CL4NLZ1umBrSct1fnyadvSJpXPh/fu1IGLIpXm+rYd1/ug++WPd
         7fQkaf1zcaed8I6MXO7w1UCCy75XVeNPOqFtTVWdu+KKBPJGug5q6ChSzHF0w9w3KSVN
         pwQQwW79mjsxEK9nYp7OPUjPUK/GbOtcZD66Lx7GDPrcLvT2gT1YSXx3tIcgmyO5sFbF
         x5nwo3IM2zgR5J66ABZwnktWnstwsqKa1PAJ15bluAAVaZ5LMDqQZ8UXexT38/1RKTV5
         AlUKGP0bkjVIDcTYZOOlX2pnTl0x4stROVNiM6zrqnsGNW91AUONCQvC2SK6hi1UT08T
         Sezg==
X-Gm-Message-State: AO0yUKWu1EurmxBtq0ZQtv0eOuAhPxM0XKOrTPCsY3oGgLicjgLUqJKe
        yvt9yaPWB/MfxaQseKh6T0mVRg==
X-Google-Smtp-Source: AK7set/96iErnptmg6+Is99No+/owz3vP8fKYml2hChGUoV9WKozzXvgBEwVPWl2hpJfJxEgqkLrqQ==
X-Received: by 2002:a50:9b13:0:b0:4aa:a856:e2d6 with SMTP id o19-20020a509b13000000b004aaa856e2d6mr10912473edi.37.1675934940541;
        Thu, 09 Feb 2023 01:29:00 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7ce0f000000b004aaa656887esm475865edv.96.2023.02.09.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:29:00 -0800 (PST)
Date:   Thu, 9 Feb 2023 10:28:59 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        palmer@rivosinc.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 1/2] RISC-V: fix ordering of Zbb extension
Message-ID: <20230209092859.5bewurwjsllmynd2@orel>
References: <20230208225328.1636017-1-heiko@sntech.de>
 <20230208225328.1636017-2-heiko@sntech.de>
 <C32D5495-F772-4887-9CAD-66206ECCFC3F@kernel.org>
 <20230209082520.solukez3jrshv3qo@orel>
 <Y+S29qPN6jmMwvi3@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+S29qPN6jmMwvi3@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 09:03:50AM +0000, Conor Dooley wrote:
> On Thu, Feb 09, 2023 at 09:25:20AM +0100, Andrew Jones wrote:
> > On Wed, Feb 08, 2023 at 11:20:10PM +0000, Conor Dooley wrote:
> > > Hey Heiko,
> > > 
> > > On 8 February 2023 22:53:27 GMT, Heiko Stuebner <heiko@sntech.de> wrote:
> > > >From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > >
> > > >As Andrew reported,
> > > >    Zb* comes after Zi* according 27.11 "Subset Naming Convention"
> > > >so fix the ordering accordingly.
> > > >
> > > >Reported-by: Andrew Jones <ajones@ventanamicro.com>
> > > >Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > > 
> > > The whole "getting it wrong immediately after fixing it up" ;)
> > 
> > Hi Conor,
> > 
> > Do you know any patchwork savvy people that could whip up a check
> > for this array? :-)
> 
> Maybe that is more of a checkpatch type thing?

I think this is too specific for general checkpatch. I once proposed on
the KVM mailing list that checkpatch should gain support for plugins,
allowing specific directories to provide a .checkpatch script, or
whatever, where it puts its own checks. I never followed-up by actually
proposing that to checkpatch maintainers though.

> 
> Either way, I'll put it on the todo list I suppose!

In the absence of checkpatch plugins, I think subsystem-specific
patch management tools, like patchwork, are the next best place
to put specific checks. But, I agree it's a bit late. It'd be better
if the developers could run the checks themselves before posting.

Thanks,
drew
