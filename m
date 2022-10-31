Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419EE613DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJaSrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJaSrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:47:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25DF13E24
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:47:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso11012786pjc.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgCBZtruL5htd+0o5fdeFssAeVeehJd/NFk3qB+xvX8=;
        b=Tp7ZfamTVj0Hv93J6UXDCmf/CCfmeEOlvhLme+JOmFcuX5c91LLgQGaBcRZQoVmBTf
         aVae1+VyL5oksMl97A5HIoWA6wumFls3+eSh0YpsCRbYuJppOA1ZKlpDFp7XLSVXsqOm
         5YZM+bgwje6vFQiryjJCkX2ZmUc/iaqadYl1ssSZLwpB+Gj2tRxo3xZDjWsOwGo4cBWV
         jXKK89FyM6xnGUADesLkJoJj/6lGu4UYIgKiDtPOFo77jsqxr6xJcvcjSs8uZCeS4pI4
         Mpt+xi5q1Kd+UWgPOCcXABkG/IgOhtO8uHLIm0n7LMmMhOiRSuu7UkCzNPkT8gG5eVrP
         TGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgCBZtruL5htd+0o5fdeFssAeVeehJd/NFk3qB+xvX8=;
        b=0yxhx1HV2/KGSX2jbgAE13YHTkXsiHUq31zFa2y3jXl6U8HEwJLdOyb9R5HPTIKwCu
         VQUxo646nuozU+vgjVNNLdeAVPdIoMIB2vkCzpfWMe+T3FUDHpH2eLN1p8qNtombR6V4
         cvN7Mggr5i38xxS4X7G1eG1/36uhZfA9qwINLJBsFQl9BvXZPt/iO/3CF4IttQhE2a1G
         GZa8uI709ZL7ZYmlr07UiTDInHmDZ9l5MgbrHd/SKthRLy3iy7P16czqUgDr/BqKp2i4
         dTJCT3Fzi20msY+zQKHkeh6Is7DI1LyPOdOA9mOmizouW07JzaEMaDSw/R+TnRn1VM/b
         mabg==
X-Gm-Message-State: ACrzQf0DfOemaTzh+qRuD3bMOtJwHsVzAXlwkiY4ovf3YuBfZWCOlWdP
        5Zd9F9BQtJt1wAYomPxNw9otgA==
X-Google-Smtp-Source: AMsMyM7jNRq4MsU7GZDzLtztTBoc8DvPq/kCD0WTORPqJlp6Vlc3GrTbmEHytsmOt3S6ihH4BQPE4w==
X-Received: by 2002:a17:902:d511:b0:186:ae37:c041 with SMTP id b17-20020a170902d51100b00186ae37c041mr15924966plg.14.1667242057346;
        Mon, 31 Oct 2022 11:47:37 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y4-20020aa79e04000000b0056c0d129edfsm4901227pfq.121.2022.10.31.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:47:37 -0700 (PDT)
Date:   Mon, 31 Oct 2022 18:47:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] KVM: selftests: Put command line options in
 alphabetical order in dirty_log_perf_test
Message-ID: <Y2AYRUhj2LLFK41k@google.com>
References: <20221031173819.1035684-1-vipinsh@google.com>
 <20221031173819.1035684-3-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031173819.1035684-3-vipinsh@google.com>
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

On Mon, Oct 31, 2022, Vipin Sharma wrote:
> There are 13 command line options and they are not in any order. Put
> them in alphabetical order to make it easy to add new options.
> 
> No functional change intended.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Reviewed-by: Wei Wang <wei.w.wang@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
