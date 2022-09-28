Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2995ED3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 06:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiI1EZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 00:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiI1EZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 00:25:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C6312084;
        Tue, 27 Sep 2022 21:25:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so11144439pgb.13;
        Tue, 27 Sep 2022 21:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XhUT4j0pqr6hZnDdBBDPYyYRf9l0yrmcaBNtZ7thxqE=;
        b=ZjGJC80iuwVAc68dbpXSUln7ojyBZF+sJr199paqV8fKNmcFL34/5Cw5KHMez97ZBD
         9I4suPudAUlXf1gYoqUSYqo6zJdfi88poBmqzLbcJf4wDSBv1ErzdLMqpncV68ghJzQW
         Qy8+Ca9nl/H8kHxq9TJvkKppj38lCrR+T44z45KIsTZFZIFVKR+lVTLJ41RtRmSY1f8Q
         utuDPzCAHurp15NYGrlcVIYpSIUB+aNIqu6npZ+z2ryWiPyqVlqwNjQUVBBwDxnqL6Uh
         SFmpkA3J9Q3ffGqHJzsdLfXoi4ikLHV/KhxjJA6mp9oHvgnsali4z4TcxYn1TNAxZAFK
         Q6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XhUT4j0pqr6hZnDdBBDPYyYRf9l0yrmcaBNtZ7thxqE=;
        b=wGbhV/5DWpXlWBaHqyZYnXcCEGqmG5tXCTuTwvDtz2+GM7ahscGpSUj3fbLR0iV4ax
         LovSMIzzBgNZErIv3xI7xkcc8WqieAVWarMUkVJYk/0FHTHhVoETGx1QkAJOWxgsHIee
         LvYcxCCa/RL+gVchhPTqSK46H+sX5gKOH97q0BfZQ+4Uxs4wgvG+Zy/uG6ZCkoaw86/M
         pWQXD22bbogDShUOgJxOqViPPCLRFII3jIdhZ3YIRuWFu6Sb8icXo0srw3//sY+fchiD
         6NAxk0Yagzs+HX2t8+xigonOAOcjvgcYQ/V6NJ8a81LZvV/HrI8k+waFGBSyh1pm6yAU
         qJzw==
X-Gm-Message-State: ACrzQf3sVBq95eIPdxWBwxSXEjBNyDBAbxmuduHtPQ/+yx9KSG5dLeKN
        qtl2gwVLgkkCDcgn3O5l/0Y=
X-Google-Smtp-Source: AMsMyM7/3d1+QVlMEKxPzEndz72bq/azP9JgMqYkmFyrABzOeHwHls2W75lowUkphsM5EyR6vPiQTA==
X-Received: by 2002:a05:6a00:1390:b0:540:b6b6:e978 with SMTP id t16-20020a056a00139000b00540b6b6e978mr32533075pfg.8.1664339112050;
        Tue, 27 Sep 2022 21:25:12 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id ci8-20020a17090afc8800b001f8c532b93dsm409007pjb.15.2022.09.27.21.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:25:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D89BB100053; Wed, 28 Sep 2022 11:25:06 +0700 (WIB)
Date:   Wed, 28 Sep 2022 11:25:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for
 new features
Message-ID: <YzPMorJQFKPY+n4d@debian.me>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JM0VvyzLnK2qTCNi"
Content-Disposition: inline
In-Reply-To: <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JM0VvyzLnK2qTCNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 27, 2022 at 03:27:00PM -0500, Babu Moger wrote:
> +        Following are the types of events supported:
> +
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +        Bits    Description
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +        6       Dirty Victims from the QOS domain to all types of memory
> +        5       Reads to slow memory in the non-local NUMA domain
> +        4       Reads to slow memory in the local NUMA domain
> +        3       Non-temporal writes to non-local NUMA domain
> +        2       Non-temporal writes to local NUMA domain
> +        1       Reads to memory in the non-local NUMA domain
> +        0       Reads to memory in the local NUMA domain
> +        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +        By default, the mbm_total_bytes configuration is set to 0x7f to =
count
> +        all the event types and the mbm_local_bytes configuration is set=
 to
> +        0x15 to count all the local memory events.
> +
> +        Example::
> +
> +            To view the current configuration, run the command.
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
> +            0:0x7f;1:0x7f;2:0x7f;3:0x7f
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
> +            0:0x15;1:0x15;3:0x15;4:0x15
> +
> +            To change the mbm_total_bytes to count only reads on domain =
0,
> +            run the command. The bits 0,1,4 and 5 needs to set.
> +
> +            # echo  "0:0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_con=
fig
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
> +            0:0x33;1:0x7f;2:0x7f;3:0x7f
> +
> +            To change the mbm_local_bytes to count all the slow memory r=
eads on
> +            domain 1, run the command. The bits 4 and 5 needs to set.
> +
> +            # echo  "1:0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_con=
fig
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
> +            0:0x15;1:0x30;3:0x15;4:0x15
> =20

Hi Babu,

The description text for each snippets above shouldn't in the code
block. Also, split the block into three code blocks in the lists:

---- >8 ----
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
index b4fe54f219b6f3..ec578b069276ce 100644
--- a/Documentation/x86/resctrl.rst
+++ b/Documentation/x86/resctrl.rst
@@ -206,25 +206,26 @@ with the following files:
         all the event types and the mbm_local_bytes configuration is set to
         0x15 to count all the local memory events.
=20
-        Example::
+        Examples:
+
+        * To view the current configuration::
=20
-            To view the current configuration, run the command.
             # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
             0:0x7f;1:0x7f;2:0x7f;3:0x7f
=20
             # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
             0:0x15;1:0x15;3:0x15;4:0x15
=20
-            To change the mbm_total_bytes to count only reads on domain 0,
-            run the command. The bits 0,1,4 and 5 needs to set.
+        * To change the mbm_total_bytes to count only reads on domain 0
+          (the bits 0, 1, 4 and 5 needs to be set)::
=20
             # echo  "0:0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
=20
             # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
             0:0x33;1:0x7f;2:0x7f;3:0x7f
=20
-            To change the mbm_local_bytes to count all the slow memory rea=
ds on
-            domain 1, run the command. The bits 4 and 5 needs to set.
+        * To change the mbm_local_bytes to count all the slow memory reads=
 on
+          domain 1 (the bits 4 and 5 needs to be set)::
=20
             # echo  "1:0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
=20

Also, there isn't description of mapping from bits from the supported events
table to the bytes input for mbm_{total,local}_config.

> +Slow Memory b/w domain is L3 cache.
> +::
> +
> +	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
> +

What b/w stands for in the context above?

>  Reading/writing the schemata file
>  ---------------------------------
>  Reading the schemata file will show the state of all resources
> @@ -479,6 +567,44 @@ which you wish to change.  E.g.
>    L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff
>    L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
> =20
> +Reading/writing the schemata file (on AMD systems)
> +--------------------------------------------------
> +Reading the schemata file will show the state of all resources
> +on all domains. When writing the memory bandwidth allocation you
> +only need to specify those values in an absolute number expressed
> +in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you
> +need to specify the value 16 (16 * 1/8 =3D 2).  E.g.
> <snipped>...
> +Reading the schemata file will show the state of all resources
> +on all domains. When writing the memory bandwidth allocation you
> +only need to specify those values in an absolute number expressed
> +in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you
> +need to specify the value 64 (64 * 1/8 =3D 8).  E.g.

s/E.g./For example:/

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--JM0VvyzLnK2qTCNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzPMmwAKCRD2uYlJVVFO
o6AMAQDE8F0f7NjBHpQMQ31FBpPpHWyjr4XHGQDiJ0BdzVIhGgEAlRDICmTkbc+2
8NzCimpiiqoQ2xEanA9+ZBoNJSbT9ww=
=tJF0
-----END PGP SIGNATURE-----

--JM0VvyzLnK2qTCNi--
