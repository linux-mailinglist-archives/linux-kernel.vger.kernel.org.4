Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F975674392
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjASUj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjASUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:39:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2EB80178
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:39:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k18so3426058pll.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oOG7jEIMwMSVx98pHdeEIROQPcBK6yIk/tw6voPDoI=;
        b=eQq1m17VX3cHIz9yZrnQ/v0cBZbsJ6m2XPACyZlzNJMfxAY6cb6dzHyfPZdd0kkFeI
         eeDwr/atGfiEy9zqjTYZB75UtnkNy6rfmzMmw3P/boqYEAkTxymw3byakudCi7P3ql42
         BdXQIVEYttFRZgay2wbUMS9A4tmjSr2lU0QXdpDnTAXLjOsTacI+6KrBY+0XVSNmq6Vy
         rUNtjjAcSdXAhN/pVIf/JfpJbcocECic0K3suhgmFiFmOibfeNgxwYMT41t6XUmt0cfD
         6eP61Nab7yGnzjgeagFOLZICmVRQNLeFDV/Fg6rdiJE3ZUYoP4mBWSywulPSgH/K1zmo
         DiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oOG7jEIMwMSVx98pHdeEIROQPcBK6yIk/tw6voPDoI=;
        b=xljQSm0rA79XDSU5nozbWuJiplCMT2WWOZr2KFkH4gwigMUS08g43tCj/oGg8PqOUc
         sBl856N296Km+6gEyczZ7dShtwd+zNYNJv+oaR6R7DE2wTm/+YCa1qvBJtlxcjQRRTq+
         PEK/2yNC6Y4Nl7PNOBMy3h/mYWG2gNf0qXX4S8g05q65yCXAZrhpR8Upa7UxN8tqRvrD
         6HlD35DztQd65Aj6huCRC537dktW94UJnoq+EWUwRztDwzVgpsBWDmGuZ6JtTBrSEJGi
         vc3IHmVQobloBCqaDMWyJPMg3IVRzQxxffhZl7WrWREWra/Q2qkD+tvgftSRBotlRji8
         W3ug==
X-Gm-Message-State: AFqh2konkezuEubv9irGCXFFtpCNTyJjsG/iMoFHKRWq4pgQYMj5MCkf
        vX1r0ZVgR/87ipQuSuiV3ZpVSA==
X-Google-Smtp-Source: AMrXdXsQQJ19RcQtuy+vYTFBkQw+exlAbBeCBJoZhTTFR5JitX8AcRoUeRmtAmU86LN9Sto8qcgCXQ==
X-Received: by 2002:a05:6a20:5492:b0:b8:c646:b0e2 with SMTP id i18-20020a056a20549200b000b8c646b0e2mr57876pzk.3.1674160764943;
        Thu, 19 Jan 2023 12:39:24 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q25-20020a631f59000000b004cffa8c0227sm3914375pgm.23.2023.01.19.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:39:24 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:39:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC 1/2] selftests: KVM: Move dirty logging functions to
 memstress.(c|h)
Message-ID: <Y8mqd7HUzXDnhXLV@google.com>
References: <20230119200553.3922206-1-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119200553.3922206-1-bgardon@google.com>
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

Please provide cover letters for multi-patch series, regardless of how trivial
the series is.

This series especially needs a cover explaining why it's tagged "RFC".
