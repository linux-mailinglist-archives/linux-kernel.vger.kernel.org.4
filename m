Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05535F6D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiJFRgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJFRgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:36:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C484B603E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:36:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so2420140pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbMGbiWLbZ6FnhZh1qaYHgBpBs3UH3NTOE+nUewVjAk=;
        b=sJHFqhoqOUNHBvPnr+m27XIxbVeg6ZTJOM+S+LzI90HY+NpwIF3qbiWbcJZk3gJwA7
         gIgZpnY31BRqpcIJlWI14mMuvg/EjCac4FesF3WRi73NlEiqTF8oZhqhHCnBbxgLlh1l
         FQWDU0OT3ZxFELn0LsZr7A8U92wBrJ6ZX6kAo75YB2qeMPu8XqRJjsYnrJ4R4BUuVjpq
         nPU+tskRY6WN9vHT5/bm3v8s78hG2PVLqKx/rPRZMCzLZlGbiaTvkTQ0sf6x7wiKMOUG
         vT0AnqVBclKoUDKEPRRAyabqHIJKu9yjG6RsDhbu9bJZev/zSkyCCfk4aDb5TfInSJ6T
         Jo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbMGbiWLbZ6FnhZh1qaYHgBpBs3UH3NTOE+nUewVjAk=;
        b=TuWI0QiowsX8e9YlP+djTYA9AF+m3V77sgU0Wmd+yb7aF1TVgwNU2nrFJquCxR/pGj
         iRBaUt7pllktbYLeJP64NaJXTYm4C+VVUDWiB21u6r2W02Hz+8j7UgY9sqIJYwk2enjt
         M2/dJIoML6vIX5scwYpLRSw10ad5f8wGRoWwD6BGXSTzM8rxec/b029rJuBuU+pJV6om
         zMBLCo+ud1xVjvSdUrCdlnF1+FATk4ECNHddyyWweTxE27MHVfcopCnERV5oUxTGab6r
         xX+kj6Q7a29B7GbMTSNhQT08CO7r4IvcH0oijwA0wGAgrx4wB2GzUmz90jRzrx+MypGj
         p9VQ==
X-Gm-Message-State: ACrzQf1wMpjSxVIukirDB01BigBxfPk+i478SqZ8qM4bxuAdrP722RTy
        jAKTfFJJ3syBp2bTzUNbx8rViQ==
X-Google-Smtp-Source: AMsMyM4Zvi84MhK8aD81L4AnUh43YBqYOPPS5pxZvSZicm45UYwmJZa5l5y0hAd252YQ2NaHw2tz1Q==
X-Received: by 2002:a63:1e47:0:b0:43c:261f:f773 with SMTP id p7-20020a631e47000000b0043c261ff773mr830690pgm.1.1665077760789;
        Thu, 06 Oct 2022 10:36:00 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b00178af82a08dsm12628456pld.91.2022.10.06.10.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 10:35:59 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:35:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcorr@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        andrew.jones@linux.dev
Subject: Re: [V4 1/8] KVM: selftests: move vm_phy_pages_alloc() earlier in
 file
Message-ID: <Yz8R+/5n63SGP5fc@google.com>
References: <20220829171021.701198-1-pgonda@google.com>
 <20220829171021.701198-2-pgonda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829171021.701198-2-pgonda@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022, Peter Gonda wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Subsequent patches will break some of this code out into file-local
> helper functions, which will be used by functions like vm_vaddr_alloc(),
> which currently are defined earlier in the file, so a forward
> declaration would be needed.
> 
> Instead, move it earlier in the file, just above vm_vaddr_alloc() and
> and friends, which are the main users.

Meh, the wrappers are one-liners, why not keep this where it is, keep it exposed,
and then make the wrappers "static inline".
