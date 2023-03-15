Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A894A6BBA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjCOQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjCOQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64AA7EE5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jN7gBsIIz2o+DPuOLs3beGrkWCBpTBuHN9nwm3qigXs=;
        b=L4NXvBqdZaqJ/JaMa/SdSJ9Z4La/kKmDhHNXTBux8Ag+BuIIOforbyRs+tyYO6R3flAbkN
        zmp28tv/yjt64Bzyij7Y1PtUl83qde0ubd3Y5Y8qVqUTjWaNo2IuZ8F5aipzvGSSIfT18m
        L6jlmF4Uj6CO6SQpAeU2144pOl90Aww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-DKEXMlZaPrmcgPVTdAF1og-1; Wed, 15 Mar 2023 12:48:21 -0400
X-MC-Unique: DKEXMlZaPrmcgPVTdAF1og-1
Received: by mail-wm1-f70.google.com with SMTP id l20-20020a05600c1d1400b003e10d3e1c23so1255176wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898900;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN7gBsIIz2o+DPuOLs3beGrkWCBpTBuHN9nwm3qigXs=;
        b=HyzvmXYd1tLvPIUpM7D+lbMUjn5tEcsYc/3wwjHU0eaoMGMAodgvN8wCrDcbp6ysNe
         30G9bozrCyaqlNDy5MITBweqRkoLs/bJz85ng15VQUG6OY8+0y0sYaLoJGE8E3VVrqt2
         eIJqLCioCbnkzhu3lBjb50rdyaDLjwxZhpTNHV7VrxfAZgwsqVie1mT0hRH2rJKF8aLa
         YOF8NfwErXXzQvb/42V3rW1nlRGWAEOhK39UTBQIKj9dyxpF7oO/R8dHRX8aPNuME/JL
         pgszpSWDp4dBIzLFeTu7gujssqsSTcTxozZxTKPaliqlBWTvZ2vzj+YSmo0iVGYVZ0z+
         EP/A==
X-Gm-Message-State: AO0yUKXgXlN4OjOMO3U7RLw4dqGofq6jwffZ9QAH8IkVk8chnVNg9IMP
        d4JzO5XW1H1pN+3Jvsho53WM9h81BdgGR1qxo9FuwpwehoR2aCuSvTyzFbz5HNjMQjQf9DvyUU3
        WzmTASPoKPIoSb8DF9Tp8mOHS
X-Received: by 2002:a5d:5090:0:b0:2ce:a8d6:5427 with SMTP id a16-20020a5d5090000000b002cea8d65427mr2284839wrt.15.1678898900830;
        Wed, 15 Mar 2023 09:48:20 -0700 (PDT)
X-Google-Smtp-Source: AK7set/7yCT9DzLtDjuAkonvARDw7EiuzZU1jup24r5YSYMqq3/If+0deo0/FhmbO4gSj7aLlCTntw==
X-Received: by 2002:a5d:5090:0:b0:2ce:a8d6:5427 with SMTP id a16-20020a5d5090000000b002cea8d65427mr2284831wrt.15.1678898900561;
        Wed, 15 Mar 2023 09:48:20 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d508b000000b002c55b0e6ef1sm5210847wrt.4.2023.03.15.09.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:48:19 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jeremy Kerr <jk@ozlabs.org>, Jakub Kicinski <kuba@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH 2/2] powerpc: use node_has_cpus() instead of nr_cpus_node()
In-Reply-To: <20230222025029.453834-2-yury.norov@gmail.com>
References: <20230222025029.453834-1-yury.norov@gmail.com>
 <20230222025029.453834-2-yury.norov@gmail.com>
Date:   Wed, 15 Mar 2023 16:48:17 +0000
Message-ID: <xhsmha60em04u.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/23 18:50, Yury Norov wrote:
> Use node_has_cpus() as more efficient alternative to nr_cpus_node()
> where possible.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

