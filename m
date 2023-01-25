Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3E67B917
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjAYSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjAYSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:14:41 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E77E4A21B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:14:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x36so22671882ede.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ezfgQvWoMwYi/wrVPbQBarXLnM5cDi1r4h1toUfXH6c=;
        b=cGn+xBZGLUGvEEQSQEj8q7PiKeDnCb14P3MOhmCCN3HhQSOmIsRjhNBB9kLQOgJPtI
         GZ3CutDFj51OwAyR8zxU2JURtxQbRtWIqvZu3wP4Di9u47Vcx6QSh1pJH4SxN8OQBniG
         YcphD1DbWFqQSMYnIEjB7qrG4s9fhM/3URZsILyle9KPNXUW/Ie1SfVlA4MevrKHCkm3
         p3YkCb9f8dmb7utnp3xYktANPPhrv9eJtYKT+P9YEWUI2htA35cEjMp5ImYJvzxExC2F
         o3R+nMif1e2BDalQApSuF2LB8IhPhh/pLT/Yj9PWnW5F7d/JKd2ZEE5cmwiwDGVKoD+G
         0iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezfgQvWoMwYi/wrVPbQBarXLnM5cDi1r4h1toUfXH6c=;
        b=eXZK3KCnBD0iM/yX1qckyXgsGpHAmGiBlhFJSSP4UxELrnIpDf1iMM5GHaEpyXEotL
         rEU2TBQu6QAtM/O2c1IEwlEXZmXQTXdNPCeOrG/LvWKKiLPQeF4Bi49y/osI44Lo2jhX
         9yjEd4YCVj/c5bjpVz1gMlYD7qa3YXYC0sstzjKNHGhg68VjvCaJN36SyAaU3sFJrHZ1
         fIkRxKSmXZNrAWXXzWsrYILpyDDbTAv1jlV5puT75b/PeeAg/4YzSg2NZUtV0/jmjAYT
         me79p+9OzxUBLvD0ouzJpQmKZY0O+lwVhP4v3H1o7xGT0vSAWbExWOiRKU2mOtYzoCS3
         WJnQ==
X-Gm-Message-State: AFqh2kqDJurGOQxaPi50yo0w7pOXaZZJCvyckY8pNffo/M3uabRCOMf2
        bs/p2droTGyqNaFyCGNl7M09jnN96hRndOkpfAt7Kw==
X-Google-Smtp-Source: AMrXdXuT6xMFHJVZ5QLk/+wQjDgjKjQNWw0t82BBGNsYvY9n1cbbZqP0y0Ny/YOsHABz+zn+gawW9hmxBLs+nRoPRDk=
X-Received: by 2002:a05:6402:2054:b0:498:216:ee4c with SMTP id
 bc20-20020a056402205400b004980216ee4cmr4403222edb.29.1674670478499; Wed, 25
 Jan 2023 10:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20230125015738.912924-2-zokeefe@google.com> <202301252110.hFYRsbrm-lkp@intel.com>
In-Reply-To: <202301252110.hFYRsbrm-lkp@intel.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 25 Jan 2023 10:14:01 -0800
Message-ID: <CAAa6QmTjn-Lnw9Sj80RCaCWmqehDSdRJVp0923UUTD68jMqoDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/MADV_COLLAPSE: catch !none !huge !bad pmd lookups
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Apologies here; shouldn't have overlooked the 4 line change. Will
follow-up with a v2 here in a second.
