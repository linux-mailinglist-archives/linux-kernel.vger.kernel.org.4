Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE548745CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGCNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGCNIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB4DD;
        Mon,  3 Jul 2023 06:08:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D237160F2A;
        Mon,  3 Jul 2023 13:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795CDC433C8;
        Mon,  3 Jul 2023 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688389721;
        bh=ypbcj87dPUAw9tzLtO/umPTpb2y3vCv6n+L9rNnzz58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xLr+Vuydj3zwqtXJDbof6qt1egJsCwGG7z1JqapZix5T/n6ja+Kwo8KTGK/Y2hItD
         6KKa493JijPBeliZnn61IYNmRt9cFvJej2Vrmki4L6PeJItT/MixQmRQzIeTPVpLDl
         fAvq9kslDMfoChfvyLMM2g2U7ug/P0An5+tF9UYc=
Date:   Mon, 3 Jul 2023 15:05:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v25 01/10] drivers/base: refactor cpu.c to use
 .is_visible()
Message-ID: <2023070342-human-spill-a62c@gregkh>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629192119.6613-2-eric.devolder@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 03:21:10PM -0400, Eric DeVolder wrote:
>  - the function body of the callback functions are now wrapped with
>    IS_ENABLED(); as the callback function must exist now that the
>    attribute is always compiled-in (though not necessarily visible).

Why do you need to do this last thing?  Is it a code savings goal?  Or
something else?  The file will not be present in the system if the
option is not enabled, so it should be safe to not do this unless you
feel it's necessary for some reason?

Not doing this would make the diff easier to read :)

thanks,

greg k-h
