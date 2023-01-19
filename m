Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DEA6743E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjASVCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjASVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:00:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FE99FDDC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674161840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tav9PKESgSqC1hA6/yzyEBrI5o5RT3fCH2ftrofh2Wo=;
        b=JAgFxLqE9r6WB868tKvm/4A1ffOdy0LRxMoTH8m+ylxW97z59fbD9HXrq4qTkCLp1fIRaz
        UCwE9vTbQL4ooRLB1iKMJETeRZjR0xVAeWlJlUiZI1kFutRGnqMRnA4pxJ3uLCrnp5T/iy
        VQXuX2rb78D8eyyCFVWsaToa/4Eqh3w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-F1Nosh-mP5SU2c_2Z4PhDw-1; Thu, 19 Jan 2023 15:57:18 -0500
X-MC-Unique: F1Nosh-mP5SU2c_2Z4PhDw-1
Received: by mail-qk1-f198.google.com with SMTP id bs44-20020a05620a472c00b0070673cd1b05so2081574qkb.22
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tav9PKESgSqC1hA6/yzyEBrI5o5RT3fCH2ftrofh2Wo=;
        b=X9Uv2WfgSWBX/UtWsXTvINZJlpWuKVhYnQcxjpU7O4/vMsHGTWSSrxq+17Rg5nPZQP
         /nSAUExGh1q7dpX44XTGmDvstLnDiujYXiNTj4Jna6+JCJlj3b5nGVrKGFN9PPdAq5av
         KzgTKWE38ppwM6Agx6MAKYtUnbeazRtoFIWF7S0+Ahcux/3v6bJXROCJ1GWETsvikhz+
         sh8DC3HWvgwp6r62gycgReEd/ZAB6t97/ksPDxi9Nyu2eD/WsSNskKlrWopOwCPzdi4S
         nPe94sIbkwXLxucMQwPxdMNo+6NFX+SxhxVX/iODIohrWIP5PukB8f8urUhR+SriKN0G
         8aLA==
X-Gm-Message-State: AFqh2krPbxyEnA+KONGBxccDa0EooHB/PsBBHZC0HTH3tv4kx7L9rf63
        fem+w0NSFIqfw2yvgIkOyxJygEoHV39uPPp15gmfM07TLviT4UotgROGMVCJnfY7r53WPyzLwqf
        FgY32LuiU03+50RNbm0QvzUKN
X-Received: by 2002:ac8:747:0:b0:3b6:30bb:966 with SMTP id k7-20020ac80747000000b003b630bb0966mr14291936qth.35.1674161837997;
        Thu, 19 Jan 2023 12:57:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsFSpGF/vWiwRs4RQ5eq4Bql9HsE3hinrslokUjoTQxRihoTcU766QQOWM/ishf969NDDOcEw==
X-Received: by 2002:ac8:747:0:b0:3b6:30bb:966 with SMTP id k7-20020ac80747000000b003b630bb0966mr14291915qth.35.1674161837691;
        Thu, 19 Jan 2023 12:57:17 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id bs25-20020ac86f19000000b0035d432f5ba3sm5521963qtb.17.2023.01.19.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 12:57:17 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [RFC PATCH 0/1] fs/namespace: defer free_mount from namespace_unlock
Date:   Thu, 19 Jan 2023 15:55:20 -0500
Message-Id: <20230119205521.497401-1-echanude@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We noticed a significant slow down when running a containers on an
Aarch64 system with the RT patch set using the following test:
# mkdir -p "rootfs/bin"
# printf "int main(){return 0;}" | gcc  -x c - -static -o rootfs/bin/sh
# crun spec
# perf stat -r 10 --table --null -- crun run test

 Performance counter stats for 'crun run test' (10 runs):

            # Table of individual measurements:
            0.3902 (-0.1941) ##########
            0.5791 (-0.0053) #
            0.5785 (-0.0058) #
            0.5891 (+0.0047) #
            0.6682 (+0.0839) ###
            0.5507 (-0.0337) ##
            0.5888 (+0.0044) #
            0.5797 (-0.0047) #
            0.5977 (+0.0133) #
            0.7217 (+0.1374) ####

            # Final result:
            0.5844 +- 0.0269 seconds time elapsed  ( +-  4.60% )

A 6.2 non-RT kernel results on the same hardware for comparison:

 Performance counter stats for 'crun run test' (10 runs):

            # Table of individual measurements:
            0.1680 (+0.1375) #################
            0.0074 (-0.0231) ###############################################################
            0.0073 (-0.0232) ################################################################
            0.0070 (-0.0235) ####################################################################
            0.0072 (-0.0233) #################################################################
            0.0794 (+0.0489) #############
            0.0078 (-0.0227) ##########################################################
            0.0070 (-0.0235) ###################################################################
            0.0070 (-0.0235) ####################################################################
            0.0068 (-0.0237) ######################################################################

            # Final result:
            0.0305 +- 0.0169 seconds time elapsed  ( +- 55.33% )

It looks like there is one bottleneck in:
-> do_umount 
 -> namespace_unlock
  -> synchronize_rcu_expedited

With the following patch, namespace_unlock will queue up the resources
that needs to be released and defer the operation through call_rcu to
return without waiting for the grace period.

Alexander Larsson (1):
  fs/namespace: defer free_mount from namespace_unlock

 fs/namespace.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

-- 
2.39.0

