Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE08648A09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLIV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLIV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:28:21 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5B579C21
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:28:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so9476051pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ7I3H9BpEe8vvUR6yxouv+T3lYTUxZ6m75wWLEW3iM=;
        b=UY4i1wDbwKFr9ivk5+M94epojTDIa9OLdQjt+R22OKDr5g6QFDpVuT/yyT3FhTr4yi
         Trvm76F9o2xCIXOc8/qj64UEbo3TzfWw9JmpTdzmd/hKZw7Kev2bHJgBe3jgVj0msPAk
         pw4LxFhjNssvKev6EVKpdFktVEvCFMu243YuP6tbK8aOpTvTKxnKYVoM/KQolrEzWFhN
         /Renvth/kF1JzcMvbZGDJqaNUDZGh+ZR1i++nPQeZQ5+GJYqKOcLcUIJhX5UBpgUvZlW
         h1mH8BmeP5z6KVsdOatWae/qo32Z2Xa7g9D4uPz+wtgRjvfU94Z9eDX9aM69pEb5WgXP
         tlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZ7I3H9BpEe8vvUR6yxouv+T3lYTUxZ6m75wWLEW3iM=;
        b=424aGOk+PLH7IdSFTlDhncUwpz3rGh9TzJ+aIWPOh8pPLbmowjf5+FkFrpICJSxCw6
         eXsBsB/Jgi8MK5AMwBz+aWRu3G3zv11+ejfj+Q8FSyKuHfxh69mHdS8O3D+YzUPcFGXt
         87Gxtjiqb7qeLlGF2YHhU/WtirxkJ8k51HF8eKRu6Vgobz2oOBPTnMXcM0/GrWbj/q8u
         Qc6y9Kio+O4BVgGB2YhEGYz1fySiXEzggWXD+0IALzqbQTBMIf7DyIqc2KGMqV5bzg9F
         3mXuv4Uf+FhpjxKVMOrJgn9ekAflu5xaNK+4oc7ocMd2U6E3JYeJgekke8mKHYNKydBi
         Cr3A==
X-Gm-Message-State: ANoB5pk84mOwUINYVfPhO2kOqojfiCqGTZvpXWXpY8Vm47qSW97NGhSW
        5gl5t2tWRrtSyqPzarmOaCLAxg==
X-Google-Smtp-Source: AA0mqf400pkS4bN6HyTsYLPsohiCJb7C/KfeyozORJNFoxyaTrS7BR9O/oQjLChwqBpp+6u29hv7tA==
X-Received: by 2002:a17:902:bc88:b0:186:748e:9383 with SMTP id bb8-20020a170902bc8800b00186748e9383mr6048233plb.46.1670621299502;
        Fri, 09 Dec 2022 13:28:19 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b00186ae20e8dcsm1726691plb.271.2022.12.09.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:28:19 -0800 (PST)
Date:   Fri, 9 Dec 2022 13:28:15 -0800
From:   David Matlack <dmatlack@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [RFC PATCH v4 0/2] Deprecate BUG() in pte_list_remove() in
 shadow mmu
Message-ID: <Y5Oob6mSJKGoDBnt@google.com>
References: <20221129191237.31447-1-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129191237.31447-1-mizhang@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 07:12:35PM +0000, Mingwei Zhang wrote:
> Deprecate BUG() in pte_list_remove() in shadow mmu to avoid crashing a
> physical machine. There are several reasons and motivations to do so:
> 
> MMU bug is difficult to discover due to various racing conditions and
> corner cases and thus it extremely hard to debug. The situation gets much
> worse when it triggers the shutdown of a host. Host machine crash might
> eliminates everything including the potential clues for debugging.
> 
> From cloud computing service perspective, BUG() or BUG_ON() is probably no
> longer appropriate as the host reliability is top priority. Crashing the
> physical machine is almost never a good option as it eliminates innocent
> VMs and cause service outage in a larger scope. Even worse, if attacker can
> reliably triggers this code by diverting the control flow or corrupting the
> memory, then this becomes vm-of-death attack. This is a huge attack vector
> to cloud providers, as the death of one single host machine is not the end
> of the story. Without manual interferences, a failed cloud job may be
> dispatched to other hosts and continue host crashes until all of them are
> dead.

My only concern with using KVM_BUG() is whether the machine can keep
running correctly after this warning has been hit. In other words, are
we sure the damage is contained to just this VM?

If, for example, the KVM_BUG() was triggered by a use-after-free, then
there might be corrupted memory floating around in the machine.

What are some instances where we've seen these BUG_ON()s get triggered?
For those instances, would it actually be safe to just kill the current
VM and keep the rest of the machine running?

> 
> For the above reason, we propose the replacement of BUG() in
> pte_list_remove() with KVM_BUG() to crash just the VM itself.

How did you test this series?
