Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E6B5FBB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJKT4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJKTz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:55:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D61177EB1;
        Tue, 11 Oct 2022 12:55:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c24so14209208pls.9;
        Tue, 11 Oct 2022 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iyHcM7UXo6+KI6U5ZBV2AMB4YpVhQ1f2WHVW8eRrXJQ=;
        b=dQbN/0BkKXoVBGYIoreyCOPFY9ii0ukdeu4JwTY8nEz9R0ae/ZfRcOD0wosr1JlFzr
         O5xsqJa6jHA8dowpEIJH6wYTzaF+VBPpn6BwljyzhpT47hB/Avc4jVIclH1HHnL7LLLW
         T3eJtlZDQE3eLrp5ndQzsX4qz584t7py4BC6wjUTrwr4GVriqxI8CSmEDPo2chgZaDWe
         2fkpC7YXn+4upKWjjFzVXn8w8Qd3foAsotDbIAlWNk0PXmTHz+N0tVitBoNExtUHphFd
         XwrPNyM5F0zUFLv1OBLApmgAz8g6t2H1zxWwOWbpPIxHWJGLeLKvLa0FhYMQZKlJzTKa
         oMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyHcM7UXo6+KI6U5ZBV2AMB4YpVhQ1f2WHVW8eRrXJQ=;
        b=1jSwu5HX+udYaDTS5DaXfS4m8X54XY/2u48yYVPiPWmVdWlZf8yRkX17qNIUFpeKjD
         TpNw6nAZO5Ciey/iQdX06EErHGg+3NgmMXfUDgb5A8GuP/EnP6954g79x0YLI4uimo5/
         8Sj0ccOp+It4ZSrj2gTtNEmIfHEM7MnMSnyjIriM0kzLLrHNY/KRbdsyRdeW4QrnR4cG
         M/pSSSqNdXbiD1P58ayThwR5acEOcKaRo0z+EKef08cGlXzMmbsLyimkf9vwBeVSS5Fi
         Edtf7wCOKznXORUGPvoEEH2H/G51wXoRntXHhNl0RyOM/Z4W2c5F5RuiwbHBBHNecVsJ
         VyjA==
X-Gm-Message-State: ACrzQf1ZTXEpzHXRYB6xGO0WCaauacZR3aslv13AAOvNEpIzCAMR3ZKO
        hRRifuzGdHfcrTuS0bJ9RePCNy/Yx/A5pA==
X-Google-Smtp-Source: AMsMyM7LLekdikl1aZ5jBm10cgtOnnqRWxrMBOTuawgR59wT7LObyxPXHsnADegCTlpdIJZLxFd9OA==
X-Received: by 2002:a17:90b:1bd0:b0:205:ed0c:7e84 with SMTP id oa16-20020a17090b1bd000b00205ed0c7e84mr921987pjb.234.1665518152627;
        Tue, 11 Oct 2022 12:55:52 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id lt23-20020a17090b355700b0020a9f7405aesm7070046pjb.13.2022.10.11.12.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:55:52 -0700 (PDT)
Date:   Wed, 12 Oct 2022 08:55:46 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y0XKQnaufTfi5OzY@mail.google.com>
References: <Y0XAxX4g/9N6qdnD@mail.google.com>
 <Y0XDAtQ4eYTgwIgM@work>
 <Y0XD9tTd0ahj2jRZ@mail.google.com>
 <Y0XGBKtNOXIz+1T6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XGBKtNOXIz+1T6@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 02:37:40PM -0500, Gustavo A. R. Silva wrote:
> On Wed, Oct 12, 2022 at 08:28:54AM +1300, Paulo Miguel Almeida wrote:
> > > 
> > I didn't add v3 here because the the patch got changed from 'replacing
> > [1]-array with flex-array' to 'replacing [1]-array to fixed-size array'.
> 
> The issue remains the same, and there have been comments and feedback on
> previous patches. So, yep, v3 seems appropiate for this patch. :)
> 
> > 
> > Let me know if you still want me to send it as v3 instead.
> 
> I think next one would be v4.
> 
> Also, when versioning patches it is also necessary to include a version
> change log.
> 
Fair enough. Will send a v4

Paulo A.
