Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B0363450D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKVT6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiKVT6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:58:47 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02CF4908E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:58:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 62so14906184pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wr/vAOyhG9MP3hDdO1FGjeLqngE8UVRb23mgHUhbTc=;
        b=fgaoW19nZrIPNgVfGeGl1uogFixm5vbuRBOEwpySC+t5eZjFg+saLkWWxRrMDxjst8
         yIE9O/00xwE0qEngbgDR8bPm8GxgnuP8VqeUIOGCOzesipqKycHFNvw7nGBU3WEEGfI/
         WuRzxnWuC0/65cxzI82JVOYWwcFEyUv8ir8s+QgZGKKKIJqOWqVKS1B2Koj1Q/YRtW1W
         ga7LtprS7NLNTUK6k45iNE5MPts8hJTkXyRKB/ImntYErET0REfYNhdcgyhrouLgLI4z
         qg6ax9q7cCNx2AGhn1QBK4bh/scgUZWU1V+Kec6vVZ4KcCHT/ziGUT5OBgGtlraueZ06
         umVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wr/vAOyhG9MP3hDdO1FGjeLqngE8UVRb23mgHUhbTc=;
        b=H+KH0Ls9oULPuHT3l+jx9UNE28SgiX46BF9LStVQ0Gm5lUJB31vTUtOHtfKKVIYeFA
         BD09ppAtn3uR7Ulzn93y/efwxDm37VAyPU9HCt5as9BKDbZGMQZHIitSpKEOQdWHRyKX
         SxqR/AhDcKky7FCxqPK4RD78A3DWaeoRhxCP3CU3cxq1AjbSn7/wwzuVpOjiM6rP2kbO
         3prxAkFQDVzTKnf0S5S/ldVWPcJCy0cju/YdJfeD1MKAMIg1xWmK+I8apS3L+g4diPzc
         XkmHcpoCqLMQTh/lBD4/lWtCHorCSo339Mf6cfUvWsoIaZTgcspm3H6o4yDFIp53bxq7
         FOIA==
X-Gm-Message-State: ANoB5pnUaIn6uMh/ZV6Lvplr6WFr4NwIE2bKvkw3C7DwgBxAQVkMPIef
        ptd/33ozuvG2QGQpDUTUhgva0w==
X-Google-Smtp-Source: AA0mqf7TZzcsmBVMdr3EsKDMNVfiWkHpYNEywsRtITM4oVjNMcX4Zcf7PgsMX2de5BERIcO7b0x2OA==
X-Received: by 2002:a63:a0c:0:b0:46b:4204:b3e5 with SMTP id 12-20020a630a0c000000b0046b4204b3e5mr8329445pgk.351.1669147126294;
        Tue, 22 Nov 2022 11:58:46 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00176d347e9a7sm12321594pls.233.2022.11.22.11.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:58:45 -0800 (PST)
Date:   Tue, 22 Nov 2022 19:58:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        dmatlack@google.com
Subject: Re: [PATCH v2 1/6] KVM: x86: hyper-v: Use common code for hypercall
 userspace exit
Message-ID: <Y30p8q0YB0+p1e+4@google.com>
References: <20221121234026.3037083-1-vipinsh@google.com>
 <20221121234026.3037083-2-vipinsh@google.com>
 <87edtvou0n.fsf@ovpn-194-185.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edtvou0n.fsf@ovpn-194-185.brq.redhat.com>
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

On Tue, Nov 22, 2022, Vitaly Kuznetsov wrote:
> Vipin Sharma <vipinsh@google.com> writes:
> 
> > Remove duplicate code to exit to userspace for hyper-v hypercalls and
> > use a common place to exit.
> >
> 
> "No functional change intended." as it was suggested by Sean :-)

Heh, I need to find a way to collect royalties.
