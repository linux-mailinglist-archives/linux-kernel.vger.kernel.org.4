Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B7622F05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiKIP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiKIP0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:26:15 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573F1902A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:26:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so17040500pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 07:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrnwmHzGRO6yNJTxXbadmZQaycrPDTYK54ATPLG4n24=;
        b=GedAx2Kx5P0BQ/6LFI1R2EYmG4w4We/Y2z0wmBT0KdDxKJap+R6NY7UG7xcQZDKHt8
         dEuc+18FuuhuaGGLm+6gnXjSTv1Jybqa2QXLVlAY2SpnFXjSh1zALSd8O1LD+9GP7DgF
         wyfLQFyKSJN72Cvs6uaMnFeHFoefqawjMteChAEP4Bzkq+8lekwvps6PHxXn/dZ1+8dL
         mE6/pD3ozFbG25MkdGDHVpDhCiTkwcfVIgK5ZyzgqIyOnuynYFS8R1PdLU0wkNxW8rlr
         vihT7XlQEvDZamdX4HM1YugWFSRu07/lfmdYMHifkbBLFwPKzEEpLIYFcpBL8UIFJT6Q
         Z7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrnwmHzGRO6yNJTxXbadmZQaycrPDTYK54ATPLG4n24=;
        b=jj6hgxS+inFhvxCsbtxL9fgGSkVC3appyvkExtMyn7cB4CiLcOs2W9pddkExIQpCYS
         TzAL4E4rZVQNsb45pdcml2rJb27Dy6W6PglshhK1byppQuhdJMZaSLlx73o2p/UToBcp
         zXAtIYG1/E/IY2oGcyBp8zfovyMc5frFZLu5e7soSJSgSgCm+HPWyPkdT1m8r2k9asQu
         sSgZug3bqpi9Vc3mrUMTo7ctiCS/ycE3gvASrOiyOqld4GtI3e+uigvfPCKmZ05Z0xW0
         tNTumymexvA00BDNgT4HJVjxWQDSq1Ld2xPHv1xKBaqUUnw9IuD+FlEkVEO5QINmNckn
         03kg==
X-Gm-Message-State: ANoB5pnLeu/3/ztXr5NgRKs9FqYg5vQkdF9aIn1AA2b1NA0G7tJk+mMd
        AJTxWapfWAA0C0JxfQQ1T/cL7w==
X-Google-Smtp-Source: AA0mqf5H21JxRaE5dbfKJQqRTwO/nDEl5Q5mFFXWxad60+bTfjFXV4lxtFEfJiXl8on6v8gyEdVzyA==
X-Received: by 2002:a05:6a00:e8e:b0:56e:3400:fdcf with SMTP id bo14-20020a056a000e8e00b0056e3400fdcfmr17374435pfb.24.1668007574315;
        Wed, 09 Nov 2022 07:26:14 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q8-20020a635048000000b00460a5c6304dsm7538297pgl.67.2022.11.09.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:26:13 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:26:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, jmattson@google.com
Subject: Re: [PATCH 06/11] KVM: SVM: remove dead field from struct
 svm_cpu_data
Message-ID: <Y2vGkkS/wXWZSMjw@google.com>
References: <20221109145156.84714-1-pbonzini@redhat.com>
 <20221109145156.84714-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109145156.84714-7-pbonzini@redhat.com>
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

On Wed, Nov 09, 2022, Paolo Bonzini wrote:
> The "cpu" field of struct svm_cpu_data has been write-only since commit
> 4b656b120249 ("KVM: SVM: force new asid on vcpu migration", 2009-08-05).
> Remove it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
