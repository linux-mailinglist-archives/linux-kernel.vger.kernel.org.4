Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E766D81A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbjDEPVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbjDEPVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423510C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680708040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEt4/fLuqkiy2IaMPsm2XYqAFwxWZjnumwAK7my1HZg=;
        b=V2HGeEemJTnBcguemwxPLde09rjQYJsxsLcLlVtEOY1XRdJ/xF6OT5yZoyEpLC8dpX34EB
        4XMk+SXcN1ddK4ywf1TeDB0nUuogBfWcEMFlba7CODJ949JexOMfJgcrI4zp+Dbf/JJD9l
        NRRTLrALlF4L+ALsnx4FujUJh7F2fa8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-nJ13xFoSOr2LDOHGFkabdg-1; Wed, 05 Apr 2023 11:17:40 -0400
X-MC-Unique: nJ13xFoSOr2LDOHGFkabdg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3e2daffa0d4so12220271cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEt4/fLuqkiy2IaMPsm2XYqAFwxWZjnumwAK7my1HZg=;
        b=z7dvQ28DAVDds4eabhR+5T+sD/bcf7WKvBCPfUxnjpf7Svc5DHnHDNnnIxUqNuZAa2
         BJdnI5chI5r2Bjtqdu3PR+TwA593OXD1gySor4NvjABrxhRCfzKr2CWWNoUGlV6DpBm9
         TlDa50WDEPToFanSChcHqR9O5GxgSiF1FP2xZf0TiY8+e3QaKL6B6OEOtSBk0VIVR85x
         oRgVc6bubQp5lGxvilN4QETZYhwbAVYA5ZzElvVAZ1DgI/NTsqnLTmHAr/2GO0RZM7Z+
         LYrj7EeuphHyN78jZiaoEwGfur6TG1aFU432WZHyNKfYwJHbSWt5q0Tsgmd8hVWU5BQD
         Y1ug==
X-Gm-Message-State: AAQBX9etX+L0J1jr6vxR9MNBeiQIwcagiQTFaBh3bhYj+rOs84gjqEYI
        vQSzU5s6fZKnPDlcf/hmQwmXTfSDCa4HZ/EmSZZKWv2FfLEjkZoAvPsVVtm2aTiItKYh7xQBmT+
        DyEDFSxlJq41NfFxgCIzJk+3G
X-Received: by 2002:a05:622a:1888:b0:3bf:cf77:a861 with SMTP id v8-20020a05622a188800b003bfcf77a861mr6152065qtc.4.1680707860126;
        Wed, 05 Apr 2023 08:17:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350b8ly/4iMZipfGPm/5Nui6FRqDLTv+FDFgHjQe3RkdJkGSapzzq0IulWhiasRWCt2Y+CphflQ==
X-Received: by 2002:a05:622a:1888:b0:3bf:cf77:a861 with SMTP id v8-20020a05622a188800b003bfcf77a861mr6152022qtc.4.1680707859781;
        Wed, 05 Apr 2023 08:17:39 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id e1-20020a05620a014100b0074a1d2a17c8sm4324729qkn.29.2023.04.05.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:17:39 -0700 (PDT)
Date:   Wed, 5 Apr 2023 11:17:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v1 0/2] mm/userfaultfd: fix and cleanup for migration
 entries with uffd-wp
Message-ID: <ZC2REi+NkyjZyyzq@x1n>
References: <20230405142535.493854-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230405142535.493854-1-david@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:25:33PM +0200, David Hildenbrand wrote:
> One fix (I have a simple reproducer but it's too long to paste it into
> the commit)

I hope the recent rework of the unit test can help having more of these
unit tests into the kselftests directly.

Currently it's still ugly even after the rework patchset - we'll need to
reference e.g. area_dst in unit tests for the allocated memory region (with
specified type of either MEM_ANON, MEM_SHMEM, ...), but there's plan to
make it even better.

Thanks for fixing those already.

-- 
Peter Xu

