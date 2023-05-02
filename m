Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023826F42BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjEBL0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjEBL0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:26:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB845B87
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:25:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so2179515f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683026740; x=1685618740;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJzvEROU1I0AevkJiXtddfuqNvgmTpgqOUa6ujqv61M=;
        b=cnhYBoZ0ai5qnsG00jozYpiSV0m20NYrDDRu32Z19HzBgq92VPvYTwbGdrKoDFMixb
         XxGbdC0qJmKDt3yzJ7xByueCfaWibMgw46nGOTp8t1thvMjjjBOg4PqLHW6RNyXCMd95
         KD8O6zs2Huc90j0nRvGyjyrBma9oT7bhB22/14MGpZh4BEALp/jca6Ptghjtg0rjLu0a
         Zl1D0LRtwT+MI63yjf+aLi8xYy4pae6tiFNV6Vo0cOIKNwzhflW1RENO2VenanJOvNKE
         9YFcm/QmOFCB/cee0TM6rnqzZt0sB4F5GMRZJptJkRDsB2M/JuEAqbG/W4fqjsJbQOeg
         29tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026740; x=1685618740;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJzvEROU1I0AevkJiXtddfuqNvgmTpgqOUa6ujqv61M=;
        b=HbxwwOQjBBKn2gt2D8G4XRqD6+MX6cu6pcRBMAqIAE2eYz3KsbN903fQtlgOfUD9hr
         ss9kdcYLGwDCihhXiZ30Elt+nZtsHByxlbnoMvAu3qfji1leX8rxMoEFoKUfRPcBvMiY
         AdMLiIpUB/4UJA6Rh8Xj6nu3Nw2NnfCU2aQPD+coGJNnSRaDKcJElyjljGs0NsErA3uA
         cs2Ga/gEnfG8UhAg7u9NZhypsLp6fi+XqHfnijcv4nOreVgGWEMECiLQdIPI7INCpz5G
         nH/TI9Q7gphB0mhkmS5wMj3dpsrH4v5wVufEbz3nzHFl1HoevNWMwAn+pvtCG0Fehhh9
         9jkw==
X-Gm-Message-State: AC+VfDwQ+F30Vc/FJ7XRSmETruJJTNbRfiD8FhCcS/f2VDaSBZ5eHaaW
        Q+v/0t1eQmc12Fg0txRtOGNOwd9lPngIV7o0Ng8=
X-Google-Smtp-Source: ACHHUZ5bdcMzV/x8+C6Jaz9Z7hwcuXWKtcl3BvyOAv1Gy3BkuEWz+IzW81eCe7IMMfMTB444O0YZgQ==
X-Received: by 2002:a5d:5703:0:b0:306:2c01:4f08 with SMTP id a3-20020a5d5703000000b003062c014f08mr5310520wrv.21.1683026739973;
        Tue, 02 May 2023 04:25:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm30844127wrz.75.2023.05.02.04.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:25:38 -0700 (PDT)
Date:   Tue, 2 May 2023 14:25:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        John Johansen <john.johansen@canonical.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: security/apparmor/policy_unpack.c:1212 verify_profile() warn: can
 'rules' even be NULL?
Message-ID: <b698c4c5-abdf-452b-ba8a-c805ab12a7e1@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   173ea743bf7a9eef04460e03b00ba267cc52aee2
commit: 1ad22fcc4d0d2fb2e0f35aed555a86d016d5e590 apparmor: rework profile->rules to be a list
config: i386-randconfig-m021-20230424 (https://download.01.org/0day-ci/archive/20230425/202304252318.ote3mtCz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304252318.ote3mtCz-lkp@intel.com/

New smatch warnings:
security/apparmor/policy_unpack.c:1212 verify_profile() warn: can 'rules' even be NULL?

Old smatch warnings:
security/apparmor/policy_unpack.c:175 aa_loaddata_kref() warn: can 'd' even be NULL?
security/apparmor/policy_unpack.c:488 unpack_trans_table() warn: impossible condition '(size > (1 << 24)) => (0-u16max > 16777216)'
security/apparmor/policy_unpack.c:544 unpack_trans_table() error: uninitialized symbol 'table'.
security/apparmor/policy_unpack.c:735 unpack_pdb() warn: unsigned 'policy->size' is never less than zero.
security/apparmor/policy_unpack.c:1081 unpack_profile() warn: passing zero to 'ERR_PTR'

vim +/rules +1212 security/apparmor/policy_unpack.c

736ec752d95e91 John Johansen 2010-07-29  1208  static int verify_profile(struct aa_profile *profile)
736ec752d95e91 John Johansen 2010-07-29  1209  {
1ad22fcc4d0d2f John Johansen 2022-09-05  1210  	struct aa_ruleset *rules = list_first_entry(&profile->rules,
1ad22fcc4d0d2f John Johansen 2022-09-05  1211  						    typeof(*rules), list);
1ad22fcc4d0d2f John Johansen 2022-09-05 @1212  	if (!rules)

It's so weird to see these old warnings show up suddenly...  Anyway,
use list_first_entry_or_null if we expect that the list is empty.
Otherwise, Oops.

1ad22fcc4d0d2f John Johansen 2022-09-05  1213  		return 0;
1ad22fcc4d0d2f John Johansen 2022-09-05  1214  
1ad22fcc4d0d2f John Johansen 2022-09-05  1215  	if ((rules->file.dfa && !verify_dfa_xindex(rules->file.dfa,
1ad22fcc4d0d2f John Johansen 2022-09-05  1216  						  rules->file.trans.size)) ||
1ad22fcc4d0d2f John Johansen 2022-09-05  1217  	    (rules->policy.dfa &&
1ad22fcc4d0d2f John Johansen 2022-09-05  1218  	     !verify_dfa_xindex(rules->policy.dfa, rules->policy.trans.size))) {
7572fea31e3e5c John Johansen 2020-11-13  1219  		audit_iface(profile, NULL, NULL,
7572fea31e3e5c John Johansen 2020-11-13  1220  			    "Unpack: Invalid named transition", NULL, -EPROTO);
736ec752d95e91 John Johansen 2010-07-29  1221  		return -EPROTO;
736ec752d95e91 John Johansen 2010-07-29  1222  	}
736ec752d95e91 John Johansen 2010-07-29  1223  
1ad22fcc4d0d2f John Johansen 2022-09-05  1224  	if (!verify_perms(&rules->file)) {
670f31774ab6bf John Johansen 2022-08-26  1225  		audit_iface(profile, NULL, NULL,
670f31774ab6bf John Johansen 2022-08-26  1226  			    "Unpack: Invalid perm index", NULL, -EPROTO);
670f31774ab6bf John Johansen 2022-08-26  1227  		return -EPROTO;
670f31774ab6bf John Johansen 2022-08-26  1228  	}
1ad22fcc4d0d2f John Johansen 2022-09-05  1229  	if (!verify_perms(&rules->policy)) {
670f31774ab6bf John Johansen 2022-08-26  1230  		audit_iface(profile, NULL, NULL,
670f31774ab6bf John Johansen 2022-08-26  1231  			    "Unpack: Invalid perm index", NULL, -EPROTO);
670f31774ab6bf John Johansen 2022-08-26  1232  		return -EPROTO;
670f31774ab6bf John Johansen 2022-08-26  1233  	}
217af7e2f4deb6 John Johansen 2022-07-29  1234  	if (!verify_perms(&profile->attach.xmatch)) {
670f31774ab6bf John Johansen 2022-08-26  1235  		audit_iface(profile, NULL, NULL,
670f31774ab6bf John Johansen 2022-08-26  1236  			    "Unpack: Invalid perm index", NULL, -EPROTO);
670f31774ab6bf John Johansen 2022-08-26  1237  		return -EPROTO;
670f31774ab6bf John Johansen 2022-08-26  1238  	}
670f31774ab6bf John Johansen 2022-08-26  1239  
736ec752d95e91 John Johansen 2010-07-29  1240  	return 0;
736ec752d95e91 John Johansen 2010-07-29  1241  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

