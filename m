Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB45B6C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiIMLVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiIMLV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:21:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C795AA38
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hC4IkMNlybq5fhEmW9iih8zIZ8yJAEnsXBHk+lgvBTk=; b=Aczea784Z7ZPCHLuwwW/2lxVyD
        XJQly3g7riWBv6NmA+0FUW2PUycbxb5NiV67AqHR06iul6rCJs+eZM1AUQDQdJ9crqh4c7lCNJwHd
        hPaDwPLsLYxFt647V2+MxPOUsYE6kJ3SAfdDuf+nDlmIV8WlXc2A5HMOmow4RyF6OncyC+rblKLv3
        O2iqdpUu73MhtsYNShDYmrEQ6Jcxedaed/IIs9FaMBae6Qg5QdRefdSPRPOZqu2NqM28ofxynSd/x
        0lW3Y5b5zJ5Mc4Admxzfg6Zfh4JFECoe0znQBFWZ0hIUHbEcyV3WnoukS5JS5rgdrqcm0u2/COIlP
        A5qotK1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oY3yE-00C3ma-EK; Tue, 13 Sep 2022 11:20:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B7C130030F;
        Tue, 13 Sep 2022 13:20:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A5DA20298A51; Tue, 13 Sep 2022 13:20:48 +0200 (CEST)
Date:   Tue, 13 Sep 2022 13:20:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Manikandan Jagatheesan <mjagatheesan@vmware.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Peter Jonasson <pjonasson@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Rajender M <manir@vmware.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        Kodeswaran Kumarasamy <kkumarasamy@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: Re: Performance Regression in Linux Kernel 5.19
Message-ID: <YyBnkES/eDbiE2xA@hirez.programming.kicks-ass.net>
References: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
 <YxxCMSYaI/o3QH03@nazgul.tnic>
 <Yx8Q1L3jNAJxa84L@nazgul.tnic>
 <PH0PR05MB84483065597B17B361CBA9ABAF479@PH0PR05MB8448.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR05MB84483065597B17B361CBA9ABAF479@PH0PR05MB8448.namprd05.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 08:40:49AM +0000, Manikandan Jagatheesan wrote:

> Are there are any ongoing activities to optimize the performance?

https://lkml.kernel.org/r/20220902130625.217071627@infradead.org

I should post a new version soonish:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git call-depth-tracking

boot with:

  spectre_v2=retpoline retbleed=stuff
