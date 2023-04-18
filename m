Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA666E6705
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjDROVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjDROVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C93C26
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681827618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTEgz5FFB3FlmpBtdJxi9kvXmr1g0kCkiAoUmPe0HM4=;
        b=ByY4VN/3fa+T0/FXabXggBbFfQuBYs+iCIxuHocf5iHlqvJVPe3o8prdrdlmX4IYT0lRKG
        1co/F7rnyKEMUz9vwLWTOYtI1QIZORa7kKq+682HeGGgogltLMwe2uWlX0Ovo8S9vmnXyu
        +QGBXJpyrfivMrgm48ETstbl1dPHQTI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-EFK9pmRJNlm7wCznza10fA-1; Tue, 18 Apr 2023 10:20:17 -0400
X-MC-Unique: EFK9pmRJNlm7wCznza10fA-1
Received: by mail-qt1-f198.google.com with SMTP id s6-20020ac85cc6000000b003e6372b917dso7856962qta.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681827617; x=1684419617;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTEgz5FFB3FlmpBtdJxi9kvXmr1g0kCkiAoUmPe0HM4=;
        b=QjufECTZ/UrNhlwD95YUKQWnybSOUUQaGoZw3o2R1dZ4eR4vbBf5nVtTjNKlckQLux
         DmtYRUqQIz2lkEc/IR1gsBAX/x3ZbV6wSiHSk8Hn8tfd8vd510wuZXK2KZnmJUE/sURt
         cZ0bKUv+1sgEOtSpn7Ld8X0/cJ+yEr+46LF7wKxrqUX1kjY2kTfIs1yr6CjpJOI7+Tk5
         9dVD7xj1EdzNpQXXyS6o3FDGpTXYruT2LxdgjEnSX9RPKVgTEVLq8hsXAXz/xos14znp
         UBKzTs9G4lBSvIDnLBtf2F8HMW89zgOyBQvoGe8Lz6u7uP4KMmRCgAAQoRLwGaNuG7Q9
         VhVg==
X-Gm-Message-State: AAQBX9cKvL/t48Si03YUkq2VGLNFkxorhSS7ar2Ayn+anmzyhUE4n3+g
        9GfDLcnvBBx+R06dIKh5TXriFHmYH9xc1CeqLy7Rl5uEFY7/feaotNgG+w1JazdhRK1DfFa4omx
        83IZAM94zqbXehpEMnn1Wdish
X-Received: by 2002:a05:622a:295:b0:3eb:1082:ec93 with SMTP id z21-20020a05622a029500b003eb1082ec93mr21708228qtw.41.1681827617179;
        Tue, 18 Apr 2023 07:20:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350bNyfIphFgQOXdbQ7b0I8+fgR55aExZiLfyClg34Zc0Jl2xZiTSAbBlkl2Gs52kSSuYH+mTfQ==
X-Received: by 2002:a05:622a:295:b0:3eb:1082:ec93 with SMTP id z21-20020a05622a029500b003eb1082ec93mr21708196qtw.41.1681827616954;
        Tue, 18 Apr 2023 07:20:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-200.dyn.eolo.it. [146.241.229.200])
        by smtp.gmail.com with ESMTPSA id w5-20020ac84d05000000b003ef28a76a11sm1704159qtv.68.2023.04.18.07.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:20:16 -0700 (PDT)
Message-ID: <ef0371ebc094e2c0778badca69ea0043b98589aa.camel@redhat.com>
Subject: Re: [PATCH linux-next 1/3] selftests: net: udpgso_bench_rx: Fix
 verifty exceptions
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yang Yang <yang.yang29@zte.com.cn>, davem@davemloft.net,
        edumazet@google.com, willemdebruijn.kernel@gmail.com
Cc:     kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        shuah@kernel.org, zhang.yunkai@zte.com.cn, xu.xin16@zte.com.cn,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>
Date:   Tue, 18 Apr 2023 16:20:12 +0200
In-Reply-To: <20230417122423.193237-1-yang.yang29@zte.com.cn>
References: <202304172017351308785@zte.com.cn>
         <20230417122423.193237-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-17 at 20:24 +0800, Yang Yang wrote:
> From: Zhang Yunkai (CGEL ZTE) <zhang.yunkai@zte.com.cn>
>=20
> The verification function of this test case is likely to encounter the
> following error, which may confuse users.
>=20
> Executing the following command fails:
> bash# udpgso_bench_tx -l 4 -4 -D "$DST"
> bash# udpgso_bench_tx -l 4 -4 -D "$DST" -S 0
> bash# udpgso_bench_rx -4 -G -S 1472 -v
> udpgso_bench_rx: data[1472]: len 2944, a(97) !=3D q(113)


As noted by Willem, both the commit message and the above command
sequence is quite confusing. Please reorder the commands in the exact
sequence you run them, presumably:

udpgso_bench_rx -4 -G -S 1472 -v &
udpgso_bench_tx -l 4 -4 -D "$DST" -S 0


> This is because the sending buffers are not aligned by 26 bytes, and the
> GRO is not merged sequentially, and the receiver does not judge this
> situation. We do the validation after the data is split at the receiving
> end, just as the application actually uses this feature.

The wording from Willem response is much more clear. If applicable,
please use such text.

BTW I could not reproduce the issue with any permutation of the
suggested commands I could think of, so possibly that section need some
extra clarification.

Thanks,

Paolo

