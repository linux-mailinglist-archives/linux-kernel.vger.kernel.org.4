Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B11D6971BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjBNXVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjBNXVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:21:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF521A13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:21:44 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v23so18620751plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wVlSW+MzcaFhWzFtR663veMvlkA/2gETJbdbvLMrqwg=;
        b=YtQfkyFjqHsFwgLK1k2ylJT9ni2w93w6RvbOhhSCH/15ARnLhvtKyJPzZ3MhtXGpg7
         cdWXC1UTFP3cd9zeCHpjnWyQaOsxOk1eH4efxLrUbr5ULex03BITFebPGEAIvx7y7au5
         W32xN1pFjjKkOZ/v4N8ddGbx9TomNuN74dKeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVlSW+MzcaFhWzFtR663veMvlkA/2gETJbdbvLMrqwg=;
        b=nQZHrjitn5rhSsC5OFbF3F7HGlJSK2VFyLyHE7S8lB0gasRktb9Hl9wzwCTJwCzKuZ
         lerEPoTVxJRLl0R8pZGjV4zmYVuTvA6+aexqFeVPFEc2HsCsCNXZISKj1EBD9hYZBYCz
         JR+IYd1O55s42TO+HEB5aL6l7pdwhdtcjqdzW0LswsQjXnhbL56+1HB4uNm3/NrVWyWp
         agH2HTVlquoYOII8OA7N2uzpe0FgW0TVtwCz81BW0meCsvpg4IXYaHpa3nW/1dmocRSQ
         rk+34tat7fObaisSO5Q8G+1uBjg7MLP30B1Jgtw9oFtGAgp/QGe81dyipK3b/wombSYN
         ZRkw==
X-Gm-Message-State: AO0yUKW9Y3zdIttjjevDsSCJ2mKght23archJPK56bJhkRCdbK/UGTD4
        se/j2jyhcU54UQiwMyliOoT1mQ==
X-Google-Smtp-Source: AK7set9q8bTv2pNuwHm4PPCPSiBfM2nKd30kkfNZw8jfMk5RqJT9oVnFuc8N8F2HAJ3AyI3Zi9kfSw==
X-Received: by 2002:a17:902:d501:b0:198:b945:4108 with SMTP id b1-20020a170902d50100b00198b9454108mr642068plg.0.1676416904081;
        Tue, 14 Feb 2023 15:21:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709029a8900b0019605d48707sm10721849plp.114.2023.02.14.15.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:21:43 -0800 (PST)
Message-ID: <63ec1787.170a0220.8e840.4d7a@mx.google.com>
X-Google-Original-Message-ID: <202302141521.@keescook>
Date:   Tue, 14 Feb 2023 15:21:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] smb3: Replace smb2pdu 1-element arrays with flex-arrays
References: <20230214215446.never.567-kees@kernel.org>
 <CAH2r5msOxm0PLoc1fAFjDnaonGVv+E1vyHxBGEh_rtAvJ_qNaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msOxm0PLoc1fAFjDnaonGVv+E1vyHxBGEh_rtAvJ_qNaQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 04:53:10PM -0600, Steve French wrote:
> This seems to have a lot of conflicts with for-next (doesn't apply).
> Any chance you could rebase it on linux-next

Ah, dang. I was working off of 20230203. I will rebase! Sorry for the
noise. :)

-- 
Kees Cook
