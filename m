Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2D6F21B4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbjD2AkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjD2AkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:40:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832DE2103
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682728810; x=1714264810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kNVHLvGHaUNwivth4S7MPLxE14wozY24Kc3pIK0NAPY=;
  b=IsQob+LQ26bqwcuCfgFEmbvzJKEw6PTmV47ELVjRqpqfEMwTnA+AUjU2
   wJrHvh9nVFeUHl19P05gsFBuQv/vhomqAtfGRBAuGgildqyI1Cy8tpdnS
   bcJKyoCQz4Tbfp390ltVJnsIDO/UGgJgRzU2ccnf/3D42RvRu5M5Yp6lZ
   hyHDfXQBIqR81g5jZTHM00IOy8oLHDIY8tpaKjiURSMyLwKIc4wgPfkE2
   fyqgv3Qh8/2hHo3yoLgF4+gbc0L4pYLst0+8rkMclFGzkT8bgcfL4xK8A
   R+qmkcqxc6pU3d9NYQLjLQ0M5LPFnsD/2H3AIMZJ+Eg7PZUESZHZX+d/H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="328226742"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="328226742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 17:40:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="725539465"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="725539465"
Received: from scha1-mobl1.amr.corp.intel.com (HELO [10.212.154.191]) ([10.212.154.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 17:40:10 -0700
Message-ID: <148b3edb-b056-11a0-1684-6273a4a2d39a@intel.com>
Date:   Fri, 28 Apr 2023 17:40:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] x86/shstk for 6.4
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
 <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
 <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <4433c3595db23f7c779b69b222958151b69ddd70.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 17:26, Edgecombe, Rick P wrote:
> Kindly placed on a host where the tags can be viewed in the commit log
> by Dave:
> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=shadow_stack_ptrace

I hope that reordering makes it more obvious and clear what's going on.
But if that turns out to still be too big of a pile to get through for
6.4, I do think the "shadow_stack_mem_thorny" in the reordered pile is a
good stopping point.

I'd be happy to prepare another pull request for the pile up to there if
it sounds sane to everyone else.


