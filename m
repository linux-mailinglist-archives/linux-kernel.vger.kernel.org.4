Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0358D69EC66
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBVBiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBVBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:38:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B87383CA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677029886; x=1708565886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l5OPc3QJtIQml8MEHfIEgFsNRCNJbyCPTa0iDWCOLEk=;
  b=ZTEuzlVdZ7kS3UVJ+txsylErwyQwKrBN406AoxgTDj8GmeV2k42ZLxfi
   R7hiXl+pNlmg+IkavJFzYYMSa7iojtJRCpVvQxxyW8eI+nbe1F8Fj4Epx
   6k89j/PWArft7U8kGG0mwWGnMEQrBWKR23LSi/L0jiV++X4kyTqIOiJ1g
   XUrHONrvOqhIiyBxZ5b4h5gL9LMcB9yK0y8QnJOs91r9OIJoVzYP87Mnx
   EY5TzKy9R7ViMS16zyCJzVtb5o+WYD6z9w5JRXlh+Z1WAeg2FaVsXIO6C
   m2PhgWjOj0Tj6as5ce1x65eZATsVVRRIao2Q66VQ4klsAb1EyC9x39+A8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="331474383"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="331474383"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:38:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="917404105"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="917404105"
Received: from erodrig5-mobl2.amr.corp.intel.com (HELO desk) ([10.212.242.195])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:38:05 -0800
Date:   Tue, 21 Feb 2023 17:38:02 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?utf-8?B?Sm9zw6k=?= Oliveira <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] x86/bugs: Allow STIBP with IBRS
Message-ID: <20230222013802.jgqem3oj6vmcixpf@desk>
References: <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble>
 <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble>
 <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble>
 <Y/O9U4KFtXE8Yoyt@zn.tnic>
 <20230220190908.gfd2c4tuzeb7cft6@treble>
 <20230222012009.bilnxhbm4lqyhhuy@desk>
 <CACYkzJ7_jYpg985GgGK17TLMJhUj0wxbSor5HE-ndN0nVgmhWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ7_jYpg985GgGK17TLMJhUj0wxbSor5HE-ndN0nVgmhWw@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 05:26:31PM -0800, KP Singh wrote:
> Pawan can you review the v2 that I sent out here:
> 
> https://lore.kernel.org/lkml/20230221184908.2349578-1-kpsingh@kernel.org/T/#t

Sure, looking at it.
